---
title: Angular 學習筆記 - 生命週期
date: 2019-10-23 22:37:52
tags: [Angular, JavaScript, LifeCycle]
---

既然 `Vue` 有一堆生命週期，那想當然 `Angular` 應該也有吧？除了最常用到的 `ngOnInit` 之外，來瞭解看看其他生命週期階段，能幫助我們在寫扣時更完整地去控制一個元件在各階段應該對資料有什麼反應。

<!--more-->

---
## Component 的生命週期

### 順序與互相關聯

|生命週期鉤子|使用時機|
|-|-|
|`ngOnChanges()`| 在`ngOnInit()`之前，及所綁定的輸入屬性值變更時都會呼叫|
|`ngOnInit()`| 第一輪 `ngOnChanges()` 完成後呼叫，只調用一次|
|`ngDoCheck()`| 緊跟在`ngOnChanges()`和`ngOnInit()`後面呼叫|
|`ngAfterContentInit()`| 第一次`ngDoCheck()`之後呼叫，只調用一次|
|`ngAfterContentChecked()`| `ngAfterContentInit()`和每次`ngDoCheck()`之後呼叫|
|`ngAfterViewInit()`| 第一次`ngAfterContentChecked()`後呼叫，只調用一次|
|`ngAfterViewChecked()`| `ngAfterViewInit()`和每次`ngAfterContentChecked()`後呼叫|
|`ngOnDestroy()`| 在元件銷毀之前呼叫|


### `OnChanges`

當元件有 `@Input()` 且從外部傳入資料時，會在初始化之前呼叫 `ngOnChanges()`，且每次傳入的值改變時，都會呼叫一次。

### `OnInit`

我們熟知的 `ngOnInit()`。在第一輪 `ngOnChanges()` 之後呼叫，元件初始化時會觸發的方法大多集中在這邊。

### `DoCheck`

`ngDoCheck()` 會在 `Angular` 核心程式執行變更偵測後呼叫，可以在這裡面寫點方法來額外處理變更偵測所無法偵測到的部分。

### `AfterContentInit`

在 `OnInit` 時還無法取得元件內容，在 `AfterContentInit` 之後就可以取得元件內容的實體。

### `AfterContentChecked`

在 `DoCheck` 週期後，會立刻觸發 `AfterContentInit` 週期，之後每當有變更偵測發生時，在 `DoCheck` 後觸發 `AfterContentChecked`。

### `AfterViewInit` 與 `AfterViewChecked`

在 `AfterContentInit` 觸發後，會觸發 `AfterViewInit`，之後觸發 `AfterViewChecked`，而在每次變更偵測後也會觸發 `AfterViewChecked`。

### `OnDestroy`

在元件消失時觸發，通常拿來清理資料或處理 `RxJS` 的 `subscribe` 退訂的動作，以免產生重複訂閱的行為。

---
參考資料：
* [Angular 官網](https://angular.tw/guide/lifecycle-hooks)
* [[Angular 大師之路] Day 04 - 認識 Angular 的生命週期](https://ithelp.ithome.com.tw/articles/10203203)