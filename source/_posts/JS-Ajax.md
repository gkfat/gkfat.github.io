---
title: JavaScript 學習筆記 - AJAX
date: 2019-10-04 14:47:53
tags: [JavaScript, Ajax]
---

為了深入學習 `JavaScript`，不能單單只是會使用 `Ajax` ，而應進一步探討 `Asyncronous JavaScript And XML`（不過大多數的 `XML` 都已被 `JSON` 取代）。
<!--more-->

---

## 首先看懂 `Ajax` 是什麼

`Ajax`：`Asyncronous JavaScript And XML`

#### `Ajax` 定義

結論放前面，`Ajax` 就是：
> 向 server 發送請求之後，可以不需等待結果，就先進行其他的任務。等 server 回傳結果，再行處理。

#### 為什麼需要 `Ajax`？

稍微了解 `JavaScript` 的人都明白，瀏覽器在讀取 JS 檔案時是一行接著一行讀取的，當一行程式碼還沒處理完畢，就不會去動下一行，也因此一行卡住了，所有人都會等它，這就是同步處理。

反之，你不確定這串程式碼會花多久時間，或你已經知道這會需要一段時間來處理，不想要網頁因為等待這串程式碼而卡住，就叫瀏覽器跳過去，先解讀其他程式碼，這就叫異步處理。

`Ajax` 就是為了完成異步處理（`Asyncronous`）而出現的手段。因為要呼叫 server 再得到回傳資料，你實在無法確定這會花多少時間，所以乾脆讓它在背景處理好之後再渲染到 DOM。

延伸應用，這也能夠提升使用者體驗。舉例來說，當使用者做了某個動作，網頁上的某部分資料會變動，透過 `Ajax` 就不需要切換整份 HTML，而只要替換變動的那部分資料就好，這才是符合使用者體驗的行為。

是不是很方便呢？

---

## 那麼，到哪裡才買得到呢？

不是啦，我是說，要怎樣才能使用如此方便的 `Ajax`？

#### `XMLHttpRequest`

第一種方式，就是透過原生的 `JavaScript` 去操作，一步步定義好每個 `XMLHttpRequest` 的 method 與 function，然後送出。

關於使用原生 JS 操作 `XMLHttpRequest`，可以參考我之前寫的 [這篇文章](https://gkfat.github.io/gk-blog/2019/09/12/JS-XMLHttpRequest/#more)。

#### `jQuery`

根據 [從ES6開始的JavaScript學習生活](https://eyesofkids.gitbooks.io/javascript-start-from-es6/content/part4/ajax_fetch.html) 提供的範例，jQuery 在 Ajax 的操作中，提供了與操作 Promise 類似的作法。

範例如下：
```javascript
$.ajax({
    // 進行要求的網址(URL)
    url: './sample.json',
    // 要送出的資料
    data: {
        id: 'a001'
    },
    // 要使用的 method
    type: 'GET',
    // 資料的類型
    dataType : 'json',
})
  .done(function( json ) {
       // 要求成功時要執行的程式碼
      })
  .fail(function( xhr, status, errorThrown ) {
       // 要求失敗時要執行的程式碼
        console.log( '出現錯誤，無法完成!' )
        console.log( 'Error: ' + errorThrown )
        console.log( 'Status: ' + status )
        console.dir( xhr )
      })
  // 不論成功或失敗都會執行的程式碼
  .always(function( xhr, status ) {
    console.log( '要求已完成!' )
    });
```

老實說，我一直沒有去碰 jQuey，因為我覺得大部分時候，原生 JS 都能解決，因此一直在加深原生的基礎。

#### `Fetch`

這是一個 HTML5 的新 API，而非 ES6 的新語法。但同時，
它也會需要使用到 ES6 的 Promise 來實作。

Fetch 如果成功的話，會回傳一個帶 response 的 Promise 物件。它的語法類似於 jQuery，但相較之下更單純：

```javascript
fetch( url, {method: 'get'} )
    .then(function(response) {
        // 在這裡處理 response
    })
    .catch(function(err) {
        // 丟出 Error :(
    });
```

不過要注意的是， Fetch 只要收到回應，都會回傳 Promise，因此需要多加注意分辨成功與失敗的狀態。

---

## `ES6 Promise` 

既然 Fetch 就是會回傳一個 Promise，那麼至少必須了解如何使用 Promsie。

直接透過範例來看會更好懂：
```javascript
let promise = new Promise(function(resolve, reject){
    // 異步處理
    // 處理完後，調用 resolve 或 reject
});

// 或者這樣做
fetch( url, {method: 'get'} ) //這裡會傳回 promise
    .then(successCallback})
    .catch(errorCallback);
```

簡單地說，Promise 的操作，就是用 `.then` 與 `.catch` 去對成功與失敗的結果分別調用 callback。

---

## `Async` `Await`

既然有了實現異步處理的工具，再來就會渴求更多。如果能夠「指定」處理的順序，那當然再好不過了對吧！

在認識 `async` 以前，我如果要設定處理順序，就會在「需要優先處理的 function」內包覆一個 callback，這樣在優先處理完 function 之後，才會去調用那個 callback，繼續處理接下來的部分（這樣寫又複雜又有機會出 bug）。

但只要在 function 前加上 `async`，就不需要再寫 callback！只要在需要優先處理的 function 前加上 `await`，所有程式就都會等這個 function 處理完之後，才繼續執行。

換句話說，`async` 會將 function 內的某部分程式碼變為「強迫單線程執行」。

綜合以上的這些技術與知識，是不是覺得更能輕鬆實作 `Ajax` 了呢？

---
參考資料：
* [從ES6開始的JavaScript學習生活](https://eyesofkids.gitbooks.io/javascript-start-from-es6/content/part4/ajax_fetch.html)
* [JavaScript Promise 迷你書](http://liubin.org/promises-book/#chapter1-what-is-promise)