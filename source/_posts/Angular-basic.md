---
title: Angular 學習筆記 - 從頭認識一個框架
date: 2019-10-21 21:48:55
tags: [Angular, JavaScript]
---

因為公司專案使用 `Angular`，為了能夠駕馭，就義無反顧地投入下去從頭學起啦！`Angular` 真的是個學習曲線很高的框架，規範相當嚴謹，但相對來說，前面規範細一點，後續維護就方便些，在這方面確實是比 `Vue` 有更多優勢的。

<!--more-->

---
## About `Angular`

### `Angular` 特色

結論寫在前面：

* `TypeScript` 定義資料型別
* `Component` 元件化的撰寫風格 
* `Services` 集中管理資料與方法
* `Modules` 各種模組供使用
* `RxJS Observables` 實現 async 作業

`Angular` 有很多特性，身為一個 JS 框架，最基本具備的就是「模組化」的能力，因此拆分成 Component 是肯定要的。不過 `Angular` 在母／子 Component 之間的導入與導出的關係這方面，定義得相當嚴謹。舉個例來說，你定義一個 class 內含的資料，原生 JS 只要寫個變數名跟賦值就好了，像這樣：
```javascript
export class myComponent {
    myName : ''; // 先給他個空值
}
```
但在 `Angular` 因為要求使用 `TypeScript` 的關係，你必須清楚定義這個變數**是什麼型別**，像這樣：
```javascript
export class myComponent {
    myName:string : ''; // 這必須是一個字串！
}
```
也許對撰寫的人而言，這樣比較麻煩，但試想專案一大、變數一多，難免會搞混每個變數應該裝什麼東西，而這樣就有助於你在看 code 的時候就先有個認知（`myName` 會是一個「字串」）這樣。對於其他維護專案的人而言，也比較好懂。難道你希望在維護別人寫的扣的時候，看到的是一堆亂七八糟的東西嗎！
```javascript
export class componentA {
    A_1 : ''; // 鬼才知道這是要放什麼！我會通靈嗎！
}
```

至於其他的特性，因為我也剛接觸不久，還不算太熟悉，就讓我們來一起發掘吧！


### 可以邊寫邊看的東西

* 跟著官方提供的風格來撰寫 Agnular 專案是比較好的：[官方撰寫風格指南](https://angular.tw/guide/styleguide)
* 加速撰寫的速度：[速查表](https://angular.tw/guide/cheatsheet)
* `Angular` 有些獨有的專屬詞彙：[詞彙表](https://angular.tw/guide/glossary)

---
## `TypeScript`

> [TypeScript 入門教程](https://ts.xcatliu.com/)

接觸 `Angular` 之前需要先對 `TypeScript` 有一定程度的了解。這類的教學在網路上有相當多資源。

### 定義類型

* boolean
* number
* string
* void（表示此函式不會返回任何值）
* null & undefined
* any（表示可以被賦予任何類型的值）

### 聯合類型

顧名思義就是可以一次宣告多個類型：
```javascript
let myNumber: string | number;
myNumber = 'seven';
myNumber = 7;
// 不會報錯
```
其他的部分，因為我也還在了解，就先不多談XD

---
## `Angular CLI`

> [官方 `CLI` 指令一覽表](https://angular.tw/cli)

終於進到本體了！當你很開心地想要創建一個 `Angular` 專案，卻發現你需要先搞好 `node` 跟 `npm`，於是決定放棄...沒啦，我們假設大家都會使用這套工具了，那就來安裝一下 CLI：
```javascript
$ npm install @angular/cli
```
移動到專案資料夾下，並透過指令產生新 `Angular` 專案：
```javascript
$ ng new myApp
// 選擇是否要啟用 routing
// 選擇 CSS format
// 開始創建專案啦！
```

官方建議透過 `ng generate <名稱>` 來新增元件，透過這指令，新元件會自動 binding 進根元件 `app` 中，供整個 `app` 取用。

透過 `CLI` 創建的 `Angular` 專案，有非常多內容，很容易頭昏眼花。[這篇文章](https://blog.gtwang.org/web-development/angular-framework-hello-world/) 有詳細的表可以參考哪個檔案的作用是什麼。

---
## `@angular/core`

一些基本的資料操作都需要先導入 `@angular/core`，另外還有一些功能會需要導入其他的模組，例如 `@angular/forms`，相關的功能與模組可以參照官方提供的表：[速查表](https://angular.tw/guide/cheatsheet)

```javascript
// 在目標 component.ts 裡導入 @angular/core
import { NgModule } from '@angular/core';
```

### 基本資料操作

```javascript
// 定義 myName 資料
export class myComponent {
    myName:string : '小明';
}

<div>{{ myName }}</div> // 會印出小明
```

### 實現雙向綁定

```javascript
// 在目標 component.ts 裡導入 @angular/forms
import { FormsModule } from '@angular/forms';
```
```javascript
// 定義空的 myName 資料
export class myComponent {
    myName:string : '';
}

<input [(value)]="myName" />
<div>{{ myName }}</div> // 會印出在 input 輸入的值
```

### 實現條件渲染

```javascript
// 在目標 component.ts 裡導入 @angular/common
import { CommonModule } from '@angular/common';
```

```javascript
// 如果條件符合 A，就渲染這個 template
<ng-template *ngIf="A">
    <p>A!!</p>
</ng-template>

// 如果條件不符合 A，就渲染這個 template
<ng-template *ngIfElse="!A">
    <p>Not A!!</p>
</ng-template>
```

### 實現條件判斷樣式

```javascript
// 在目標 component.ts 裡導入 @angular/common
import { CommonModule } from '@angular/common';
```

```javascript
// 如果條件符合 A，就 background-color='blue'，否則 'red'
[style.background-color]="A ? 'blue' : 'red'"

// 或一次判斷多個樣式
[ngStyle]="{
    'background-color': A ? 'blue': 'red',
    'border' : A ? '1px solid red' : 'none'
}"

// 綁定 class
[class.<className>]="<達成條件>"

// 更進一步綁定 class
[ngClass]="myFunction()"

myFunction() { // 須在 component 定義 function
    let myClasses = {
        classA: <條件A>,
        classB: <條件B>
    }
    return myClasses;
}
```

以上都相當基本，所以做個筆記就過去了。

---
## `Routing`

如果一開始創建專案時沒有選擇要 `Routing` 但後來又想用的話，可以使用 `CLI` 產生 `Routing`。

```javascript
$ ng generate module app-routing --module=app
// --module=app：將它註冊到 AppModule 的 imports 陣列中
```

---
## `Component`

透過 `CLI` 產生的 `Component`，會自動幫你綁定在 `app` 裡。

```javascript
$ ng generate component myApp
// 或更偷懶的寫法：
$ ng g c myApp
```
會在 `app` 資料夾中產生一個 `myApp` 資料夾，並在 `app/myApp` 裡產生四個檔案：
```javascript
myApp.component.html
myApp.component.css
myApp.component.ts
myApp.component.spec.ts
```

其中 `spec` 檔是跑測試用的，對於規模較小的專案就比較不需要注意這個。其實也是因為我還沒了解，所以就先不談。

---
## `Service`

一樣，用 `CLI` 來產生一個 `service`：
```javascript
$ ng generate service
```

接著，在 `Component` 中導入 `Service`：

```javascript
// 在目標 component.ts 檔案裡導入 service
import { HttpService } from '~/http.service';

// 在 export 中做以下宣告
export class myComponent implements OnInit {
    // 宣告一個叫 _myHttp 的私有 service
    constructor( private _myHttp: HttpService ){}
    
    ngOnInit() {
        // Init 時就啟用 myMethod() 方法
        this._myHttp.myMethod();
    }
}
```

私有的概念就是不容許外部存取，有點類似 `scope` 的概念。

---
## `Observable` 與 `RxJS`

專案有點規模了之後，總是會需要用到 async，在 `Angular` 中要使用 async 的方式就是 `Observable` 以及 `subscribe`（用法類似 `Promise` 跟 `.then`），不過其實我也還沒搞得很懂，所以就先筆記到這裡，之後比較清楚了再回來談。

---
## 結語

`Angular` 實在不是個好理解的框架，但學習曲線高，值得好好學習。熟練之後，對於模組化的 coding style 也能有所幫助的吧。

---
參考資料：
* [Angular 網頁應用程式 Hello World 教學](https://blog.gtwang.org/web-development/angular-framework-hello-world/)
* [Learn Angular 8 from Scratch for Beginners - Crash Course](https://www.youtube.com/watch?v=_TLhUCjY9iA)
* [希望是最淺顯易懂的 RxJS 教學](https://blog.techbridge.cc/2017/12/08/rxjs/)
* [TypeScript 入門教程](https://ts.xcatliu.com/)