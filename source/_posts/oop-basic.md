---
title: OOP 學習筆記 - 什麼是物件導向程式設計？跟前端開發有什麼關係？
date: 2021-11-23 19:57:57
tags: [OOP, TypeScript, SOLID]
---

近來在開發網頁時，逐漸能感受到事先訂好類別規格的重要性。比方說，這次要新增的功能是「股票觀察清單」，若能事先定義好觀察清單、觀察對象（EX: 股票）、觀察清單的行為（EX: 建立、編輯、移除），那麼在開發時會清楚許多，往後若要為這功能增加或改動內容（維護階段），都可以從源頭來改。降低 bug 發生機率的同時，也能讓其他同事更迅速理解自己寫的架構，減少溝通鴻溝。為此，該來將先前粗略讀過的「物件導向程式設計」概念，拿出來再理解一遍了。

<!--more-->

---
## 什麼是物件導向程式設計（Object-Oriented Programming）？

> 根據 [《UML 物件導向系統分析與設計》](https://www.sanmin.com.tw/product/index/000747473)，在物件導向設計中，類別（Class）的實例（Instance）就叫做物件（Object）。物件作為程式的基本單元，每個物件都是獨立的個體，應該要能夠接收資料、處理資料、傳出資料，採用物件導向來設計程式，能夠大大提升程式的靈活性與可維護性。

* 類（Class）：定義一個東西的抽象特徵。包含資料的形式以及對資料的操作。
* 物件（Object）：是類的實例，類產生的具體例子。

就像這類文章常見的那個例子一樣：
```javascript=
// 宣告一個 class，包含屬性以及方法
class Person {
    name;
    
    constructor(pname) {
        this.name = pname;
    }
    
    murmur() {
        console.log("我是" + this.name + "嗎?");
    }
}

// 宣告實例
let ming = new Person("小明");
let hua  = new Person("小花");
ming.murmur();  // 我是小明嗎?
hua.murmur();   // 我是小花嗎?
```

`Person` 是一個 Class，而 `new Person()` 則會建立一個實例 Object。

在初步了解物件導向是什麼了之後，就來看看它有哪些特性，以及需要依照怎樣的原則來設計程式吧。

---
## 物件導向四大特性

物件導向有四個特性：
* 抽象（Abstraction）
* 封裝（Encapsulation）
* 繼承（Inheritance）
* 多型（Polymorphism）

說真的，當時的我看到這些鬼東西，真是害怕極了。如今卻能大致理解這四項特性分別是在描述什麼，應該是有所成長了吧。

### 1. 抽象（Abstraction）
我自己覺得這可能是最難理解的概念，但是一但理解了抽象性，對於思考程式如何設計會有相當大的幫助。其實換個角度想，我們在生物課不就學過抽象性了嗎？

> 不信你看：[生物分類法 - 維基百科](https://www.itsfun.com.tw/%E7%95%8C%E9%96%80%E7%B6%B1%E7%9B%AE%E7%A7%91%E5%B1%AC%E7%A8%AE/wiki-169944-298424)

就我目前的理解，抽象就是一種分類的方法。透過整理來將一類對象抽象化，而定義出這個類別的特性及行為，以幫助人快速識別對象。這個道理是從大自然中學習來的，而套用在程式設計上也相當合用。

就像上面的例子一樣，小明與小花都屬於 `Person` 這個 Class，但各自的 `name` 及 `murmur` 的內容卻又不同。

### 2. 封裝（Encapsulation）
封裝是將 Class 的部份內容包裝、隱藏起來的方法。這是一種防止外界呼叫、存取物件內部實作細節的手段。聽起來很美好，問題是親愛的 `JavaScript` 中並沒有簡單明瞭的設計來實現物件導向封裝特性。幸好，我們有 `TypeScript`。透過 `public` `private` `protected` 就能夠快速簡便地讓開發者及系統辨別公開或私有屬性。

### 3. 繼承（Inheritance）
一個物件有時會在父類別底下延伸出子類別，子類別會比父類別更加具體（但不是實例），且繼承父類別的屬性。

比方說開頭提到的觀察清單類別，因為需要能夠容納「股票」類別以及「外匯」類別，就可以再分為「股票觀察清單類」及「外匯觀察清單類」。源頭都屬於觀察清單類別，但各自又多了部分不同的屬性。

### 4. 多型（Polymorphism）
由繼承產生的相關的不同類別，這些類別對同樣的呼叫，會給出不同的反應。這是什麼意思呢？讓我們修改一下開頭的案例：
```javascript=
class Person {
    murmur(){} // 此處定義了一個方法，但沒有內容
}

class MalePerson extends Person {
    murmur() {
        console.log("我是男漢子!"); // 定義內容
    }
}

class FemalePerson extends Person {
    murmur() {
        console.log("我是女漢子!"); // 定義內容
    }
}

let man = new MalePerson();
let woman = new FemalePerson();
man.murmur();   // 我是男漢子!
woman.murmur(); // 我是女漢子!
```

如上所示，在新類別繼承了 `Person` 這個類別時，也一併繼承了它的 `murmur()` 方法，並各自覆蓋了方法的內容。接著建立實例並呼叫此方法的時候，就會印出各自的內容，這就是多型。

---
## 物件導向設計 SOLID 原則

> [SOLID (物件導向設計) - 維基百科](https://zh.wikipedia.org/wiki/SOLID_(%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E8%AE%BE%E8%AE%A1))
> 每個專案沒聽到一次就渾身不對勁的 S.O.L.I.D. 原則

`SOLID` 原則是取以下五個原則的開頭組合而成，剛好也表示依循這樣原則的程式設計會很「穩固」。因為要深入淺出這五個原則，以我目前的功力還辦不到，所以只能簡單做個筆記。有錯誤的部分也歡迎隨時指正。
* 單一職責原則（Single responsibility principle, SRP）
* 開放封閉原則（Open-Close principle, OCP）
* 里氏替換原則（Liskov substitution principle, LSP）
* 介面隔離原則（Interface segregation principle, ISP）
* 依賴反轉原則（Dependency inversion principle, DIP）

### 1. 單一職責原則(Single responsibility principle, SRP)

```
一個模組應該只對一個角色負責。
```

依我的理解，這意思就是一個 `calcTotal()` 的函式，不應該同時做多件事情，例如修改 `CompanyWallet.total` 以及 `CustomerWallet.total`，以防哪天因為變更了一點點 `calcTotal()` 的程式碼，卻影響到其他內容，這是會出大事的。

那麼依循這個原則，可以這樣做：

```typescript=
// 建立一個抽象的介面，包含計算函式但不實作
class TotalCalculator {
    public function calcTotal(): number;
}

// 各自繼承並實作計算函式的內容
class CompanyWallet extends TotalCalculator {
    private total: number;
    public function calcTotal() {
        // 公司的計算方式
    }
}
class CustomerWallet extends TotalCalculator {
    private total: number;
    public function calcTotal() {
        // 客戶的計算方式
    }
}
```

目前的我還不能很好地舉例解釋單一職責原則，或許是因為尚未滲透進骨髓，必須再繼續加深印象才行。


### 2. 開放封閉原則(Open-Close principle, OCP)

```
開放擴展：當需求變更時，模組可以擴充功能。
封閉修改：當進行擴沖時，模組不需修改既有的程式碼。
```

當一個已經完成的模組要加上新功能時，不應修改原本的程式碼，否則很有可能會在想像不到的地方產生 bug，這是很好理解的。

### 3. 里氏替換原則(Liskov substitution principle, LSP)

```
子類別要能取代它的父類別。
```

大意是說，子類別繼承了父類別，實作時需依循下列原則：
* 子類別的先決條件不能比父類強，但可以比父類弱
* 子類別的後置條件不能比父類弱，但可以比父類強
* 父類別的不變條件必須被繼承

乍看很抽象，但用具體例子來看的話，就很好理解。基本上就是子類別實作的範疇不應跳脫父類別，而應該在父類別的範疇內實作。

### 4. 介面隔離原則(Interface segregation principle, ISP)

```
使用不到的功能，不應被呼叫。
```

一樣又是很抽象的說明，具體舉個例子就是：
```javascript=
class Website {
    public function login();
    public function logout();
    public function adminMode();
}
class Client {
    site = new Website();
    site.login();
    site.logout();
    site.adminMode(); // 明明是 client 為什麼可以開啟 admin?
}
```

因為 `adminMode()` 並不是開放給所有人使用的，但偏偏 client 又可以呼叫它，這就表示違反了介面隔離原則。此時需要將 `adminMode()` 隔離出來，只有管理員可以實作這個介面，並呼叫本功能。

### 5. 依賴反轉原則(Dependency inversion principle, DIP)

```
高層模組不應依賴低層模組，而都應該依賴抽象。
```

當高低模組之間有依賴關係時，此時就會有危險產生。萬一高層模組依賴低層模組，而低層模組的實作內容修改了，高層模組就會發生預期外的結果，要不然就必須去修改高層模組內容，出現高耦合的狀況。

為了避免，可以在高低模組之間抽出一個抽象的介面，透過抽象去實作方法，這樣就可以降低耦合。


以上就是 `SOLID` 原則。以我目前的程度，大概只有一知半解，而且要依照原則來設計程式，又比單純理解物件導向更難了。

但我相信 `OOP` 能讓程式變得更好，所以我會持續精進 `SOLID`！

---
## OOP 如何應用在前端開發？

前端工程師在學習的過程中幾乎都會看到「`JavaScript` 是一個基於物件導向的語言」這句話，接著就會看到原型鏈（Prototype）相關的介紹。當時的我還不是很能把這兩件事串在一起，如今看來之間的關聯再明顯不過了。

再回到前面的例子，其實 `JavaScript` 的 Class 並不是真正的類別，而只是個偽裝過的 function，也就是常聽人家說的那一句：「Class 只是 ES6 的語法糖」。但是 ES6 究竟為何要這樣欺騙我們的感情呢？還不是為了讓你開發上更方便（巴頭）！關於這件事，MDN 是這樣說的：

> [繼承與原型鏈 - MDN](https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Inheritance_and_the_prototype_chain)
> JavaScript 是個沒有實做 class 關鍵字的動態語言，所以會對那些基於類別（class-based）語言（如 Java 或 C++）背景出身的開發者來說會有點困惑。（在 ES2015 有提供 class 關鍵字，但那只是個語法糖，JavaScript 仍然是基於原型（prototype-based）的語言）。

我目前對於 `Prototype` 還沒有系統性地去理解過，只大致上知道是怎麼回事而已，但這不是本篇主旨，所以先跳過。

我關心的是，究竟 <strong>OOP 如何應用在前端開發</strong>？

### 搭配神兵利器 `TypeScript`

因為目前公司使用的前端框架是 `Angular`，使用的主要語言是 `TypeScript`，也因此潛移默化地習慣了事先定義型別、類別的作法，自然養成好習慣。現在要我用原生 JS 開發，如果要像 `TypeScript` 那樣定義型別，要花一大堆功夫，心裡會很不是滋味。

如果 `OOP` 搭配使用 `TypeScript`，那麼在開發事前就能將類別、資料型別定義得更清楚了，倘若再用上 `UML`（這才發現我沒寫過 `UML` 的筆記，看來也該補一篇了）來分析專案，在前期就徹底分析需求，就可以大大減少遺漏需求的問題，也可以減少發生後端都已經部署好 API 了，前端卻在串接過程中發現資料格式不合用想要改結構的情況。這有時候是會影響到 DB schema 的，若能事先定好，就能在前期發現該釐清的事項。

因此接下來我會用 `TypeScript` 來呈現 `JavaScript` 的部分。

### 從「物件」作為出發點來思考

程式是「本質先於存在」的產物，必須先有「需求」，而後才有對應的「解決方案」。若要在專案開發中導入 `OOP`，必須從需求分析切入，後續發展才能順暢。讓我們先假設一個需求：

```
開發一個檔案上傳管理系統。
```

好啦，老實說就是這個經驗：[後端學習筆記 - 來寫一個串接 NAS 的檔案管理服務吧！](https://gkfat.github.io/2021/09/05/python-file-upload-service)，不過當時的我並沒有將物件導向設計應用進去，因此若現在回頭看程式碼，不吐血才怪。

現在從頭來思考這個需求，我會先做 `UML` 中的類圖分析，拆解出這個需求中包含下列類（Class）：

```typescript=
// 檔案
class UploadFile {
    public id: number;      // 檔案 ID
    public name: string;    // 檔名
    public content: string; // 檔案內容，以 base64 儲存
    public path: string;    // 上傳的路徑
}

// 使用者
class User {
    public id: number;      // 使用者 ID
    public name: string;    // 使用者名稱
    public uploadFile(){}   // fn: 上傳檔案
    public removeFile(){}   // fn: 刪除檔案
    public readRecord(){}   // fn: 查詢上傳紀錄
}

// 上傳紀錄
class UploadRecord {
    public id: number;      // 上傳紀錄 ID
    public fileID: number;  // 檔案 ID
    public userID: number;  // 使用者 ID
    public uploadTime: Date;// 上傳時間
}
```

花個 3 分鐘簡單拆解而已，就能大致看出個輪廓了（當然要能開始開發還遠遠不夠）。類圖分析完後，接著就能用活動圖來分析使用者、前端、後端、資料庫之間的活動，以及活動內容，再來就能推出各自要開發的項目細節了。

---
## 結論

如此麻煩地套用 `OOP`，究竟會產生哪些影響？
* 分析：搭配 `UML` 能更系統化分析專案，在前期就盡可能釐清 spec
* 開發：開發過程中能清楚正在處理的資料型別，不用瞎子摸象亂猜一通
* 協作：他人能更迅速理解程式碼的邏輯，工程師間的溝通更順暢
* 維護：debug 或修改屬性、擴充功能都更方便

最重要的，是幫助自己在程式設計的領域中提升思維高度，以更全面的角度來看待整個專案，對於成長很有幫助。

所以，一起來學吧！

---
參考資料：
* [物件導向程式設計 - 維基百科](https://zh.wikipedia.org/wiki/%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1)
* [UML 物件導向系統分析與設計 - Jim Arlow](https://www.sanmin.com.tw/product/index/000747473)
* [TypeScript | 從 TS 開始學習物件導向 - Interface 用法 - 神Q超人](https://medium.com/enjoy-life-enjoy-coding/typescript-%E5%BE%9E-ts-%E9%96%8B%E5%A7%8B%E5%AD%B8%E7%BF%92%E7%89%A9%E4%BB%B6%E5%B0%8E%E5%90%91-interface-%E7%94%A8%E6%B3%95-77fd0959769f)