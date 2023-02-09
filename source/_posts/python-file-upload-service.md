---
title: 後端學習筆記 - 來寫一個串接 NAS 的檔案管理服務吧！
date: 2021-09-05 08:31:08
tags: [後端開發, Python, API, NAS]
---

公司裡有個部門每天都會產出一定份量的繪圖檔案，目前都是人工手動上傳到 NAS，但是對於資料夾與檔案的命名卻沒有任何規範，根本就是個野生叢林！該部門的主管想建立一套規則來更有系統地管理這些檔案（還有管理這些繪圖人員），因此開了這個需求給我。

<!--more-->

* [需求解析](##需求解析)
* [開發](##開發)
* [部署](##部署)

---
## 需求解析

### 前言
（~~客戶~~）某部門主管：「可以幫我做一個上傳圖紙到 NAS 的工具嗎？簡單就好，不要花你太多時間。」
GK：「（你知道我只是個前端工程師嗎？）好啊，沒問題，你的需求是什麼？」
（~~客戶~~）某部門主管：「？就是剛剛說的那樣啊...」
GK：「？？？哦......好...好吧...」

由於某些原因，我的部門裡沒有後端工程師，沒有系統分析師，也沒有 DBA，全部都得自己來。幸好經歷過 [這個歷練](https://gkfat.github.io/2021/03/19/system-deploying/)，我對於要建立一個系統服務，還算是有點概念。

看來，這又是天上掉下來的機會，要讓我拓展視野了。

### 系統分析
在開始寫程式之前絕對該做的事，就是系統分析（SA）。首先把我的角色從 `產品經理（PM）` 切換成 `系統分析師（SA）`，經過一番思考後，犧牲了不少腦細胞，但也得出以下架構（因為涉及公司隱私，所以公開的部分有簡化過）。

#### 系統架構

|服務|選擇|
|-|-|
|VM|Linux CenteOS 7（既有）|
|Backend Application|Python3|
|Database|MariaDB（既有）|
|Web Application|Angular 11|
|HTTP Server|Apache|

> 本來是想學著用 Golang 開發的，但為了讓另外幾位 Python 底的工程師也能夠維護或擴充這個服務，就選擇用 Python 了（反正兩個都是從頭學）（~~但寫完這個專案後我真的是很討厭 Python~~）。

#### 活動
* 上傳檔案功能
    * 可將檔案上傳到 NAS 目標資料夾，並儲存紀錄至 DB
* 查詢紀錄功能
    * 可取得 DB 上傳紀錄，並做分頁、排序、篩選
* 同步 NAS
    * 可同步 NAS 上資料夾與 DB 客戶、型號

#### 類別設計
* 檔案上傳紀錄類
* 客戶類
* 型號類

#### 資料庫設計
* NAS 同步紀錄表
* 客戶表
* 型號表
* 檔案上傳紀錄表

#### API 設計
* 同步 NAS API
* 上傳檔案 API
* 查詢紀錄 API
* 查詢客戶、型號 API

#### 介面
* 上傳檔案頁面
    * 取得客戶、型號
    * 選擇檔案，組成目標格式
    * 上傳檔案
* 查詢紀錄頁面
    * 同步 NAS
    * 查詢上傳紀錄（分頁、排序、篩選）

大致上就完成了一次簡易版 SA 分析，接著就是依據這些規格來開發了（角色切換成 `後端工程師(Back End)`）。如果開發文件寫得我看不懂，我就定死你 SA！欸，等等，SA 也是我自己？

---
## 開發
好的，那麼來到了工程師們最喜歡的開發橋段了。有了辛辛苦苦做好的 SA 分析，就可以照著步驟無腦開發了！當然因為一條龍都是我，就沒有把規格訂得太詳細了，開發時再想就好了（這真的不是一個好習慣，後來在整理時發現，要寫 API 文件或後續要再擴充，都要再從程式碼裡找規格）。

### 後端開發

#### 選擇套件
因為 Python 套件非常多，在網路上查詢整理後，選擇了這幾個套件來做核心處理。

|套件|處理範圍|
|-|-|
|flask|http server|
|flask-sqlalchemy|DB 相關操作|
|pysmb|NAS 相關操作|

#### 專案架構
愉快的開發時間就咻地略過，來看看完成後的模樣吧。以下是憑~~直覺~~後端基礎寫出來的架構。
```
file-uploader
|-- app.py                // 專案的進入點，啟動 http server
|-- deploy.sh             // 讓懶人可以一鍵部署到虛擬機的 Shell Script
|-- venv                  // Python 必備虛擬環境，套件都裝在裡面
|-- config                // DB、NAS 連線帳號密碼設定檔
    |-- config.py
|-- connection            // 處理連線，原本裡面有 DB 連線，後來發現不需要
    |-- conNas.py
|-- model                 // Model 與 Table schema
    |-- dbTable.py
|-- view                  // API routes 以及分配到哪個 Controller
    |-- fileUpload.py
|-- controller            // 業務邏輯
    |-- uploadControl.py
    |-- retrieveControl.py
    |-- deleteControl.py
    |-- fetchControl.py
    |-- customerControl.py
    |-- syncControl.py
```

以上是大致上的專案架構說明，大部分 Controller 都大同小異在對 NAS、DB 做一些基本的 CRUD 操作。比較值得一提的是在 `controller/uploadControl.py` 裡面對上傳檔案的操作，若一次上傳多個檔案，有開 `thread` 來並行處理，大概的程式碼如下：

```python=
// 上傳檔案
def UploadFile():
    uploadList = []  // 要上傳的檔案陣列
    
    // 從 API 取出要上傳的檔案，加入 uploadList
    for item in request.get_json()['files']:
        uploadList.append(dict(
            state = 0,    // 檔案上傳成功／失敗狀態
            file  = item
        ))
    
    // 產生多個 Thread，分別執行檔案上傳
    for file in uplaodList:
       uplaod_thread = threading.Thread(
           target=UploadControl.UploadFileThread,
           args=(item,)   // 少了那個逗號會有問題，我也不曉得為什麼
       )
       file = upload_thread.start()
       
       // 等全部的 thread 都完成後才進行下一步
       uplaod_thread.join()
    
    // 一些跟 DB 有關的操作
    // 回傳 API response


// 每個 Thread 上傳檔案的操作
def UploadFileThread(file):
    // 一些跟 NAS 有關的操作
    // 回傳檔案上傳結果
```


### 前端開發
前端就不是筆記的重點了，就是依 SA 分析的功能來開發。
* Model：用 `typescript` 的 `namespace` 來建立類別 struct
* UI：用 Bootstrap 達到最基本的呈現
* UX：跳過 wireframe，靠經驗

#### 拖曳上傳檔案
比較值得一提的地方是，這次嘗試用 Angular 的 `directive` 來製作出「拖曳式上傳檔案」的監聽檔案拖曳區域，內容相當簡易：
```javascript=
// dropZone.directive.ts
import { Directive, HostListener, Output, EventEmitter } from "@angular/core";
import * as $ from 'jquery';

@Directive({
  selector: '[appDropZone]'
})
export class dropZoneDirective {
  @Output() filesDropped = new EventEmitter<any>();

  @HostListener('dragover', ['$event']) onDragOver($event: any) {
    $event.preventDefault();
    $event.stopPropagation();
    $('.dropZone').addClass('grayBGC');
  }
  @HostListener('dragleave', ['$event']) public onDragLeave($event: any) {
    $event.preventDefault();
    $event.stopPropagation();
    $('.dropZone').removeClass('grayBGC');
  }
  @HostListener('drop', ['$event']) public onDrop($event: any) {
    $event.stopPropagation();
    $('.dropZone').removeClass('grayBGC');
  }

}

// upload.html
<div class="dropZone" *ngIf="canUpload" appDropZone (filesDropped)="chooseFile($event)">
    <input #fileDropRef id="fileDropRef" type="file" multiple
            (change)="chooseFile($event)">
    <h5>拖曳檔案至此處</h5>
    <label for="fileDropRef">
        或點擊此處選擇上傳檔案
    </label>
</div>
```

基本上就只是在監聽「拖曳進入」「拖曳離開」事件，為區域加上 css 讓使用者得到回饋，然後在「丟下檔案」的時候，emit 給 `upload.ts` 的 `chooseFile()` 接收。

另外還有用 `cdkDropList` 結合 `bootstrap` 卡片呈現，製作出拖拉調整順序的介面。除外的就不值一提，很普通XD。

---
## 部署
後端跟前端都寫好之後，部署的順序如下：
* 將後端專案複製到虛擬機專案路徑底下
    * 對目標 DB 做 Migration
    * Systemctl 建立 service daemon file
    * 啟用服務
* 將前端專案複製到虛擬機專案路徑底下
    * 設定 Apache proxy，將目標網址導向後端 API 或前端網頁
    * 設定防火牆，讓使用者能存取 port

### Database Migration
在 Migration 這關其實也摸索了滿久的，後來逐漸認知到步驟其實很單純（我用 `flask-sqlalchemy` 來做 DB Migration）：
* `flask db migrate` 來產生 migration file（比對 `dbTable.py` 中 table schema 與目標資料庫中的 schema）
* 檢查 upgrade file 裡的操作是否都符合需求
* `flask db upgrade` 就 Migrate 成功啦！

至於 `backup`、`rollback`，就之後再考慮吧。

### Linux Service

> 之前有整理過一份 `systemctl` 的操作，指令都在 [這裡](https://gkfat.github.io/2021/08/01/linux-systemctl/)。
* 在虛擬機建立 system daemon file
* `systmectl daemon-reload` 來載入 service
* `systemctl start <service>` 就啟用服務啦！

---
## 結語
現在回頭看看，2021 年初時我還連 DB 怎麼下 query 都搞不懂，連 Linux 都不會操作，過了半年後，居然能夠一條龍做到下列事項：
* 使用 Python 撰寫 http server、撰寫 API 文件、撰寫方便部署的 Shell Script
* 串接 MariaDB 資料庫、執行 DB migration、串接 NAS
* 使用 Angular 串接 http server
* 部署後端服務、前端專案到虛擬機
* 設定 Apache、防火牆讓使用者能夠連線

真的是滿感謝有這個大好機會，讓我對整套專案的執行有了進一步的了解（但不敢說這就叫全端），經過了一兩季後，這個專案也已經逐漸成長到了 1.5 版本，對於後端也愈來愈能理解了。接下來想把重心放在學習 Golang，以及加強後端 Concurrency 處理的觀念。

---
參考資料：
* [TechBridge 技術共筆 - 簡明 SQL 資料庫語法入門教學](https://blog.techbridge.cc/2020/02/09/sql-basic-tutorial/)