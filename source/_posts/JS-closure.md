---
title: JavaScript 學習筆記 - Closure
date: 2019-09-17 16:43:24
tags: [JavaScript, closure]
---
面試以來常常碰到的一題，就是 `closure`。我知道中文叫閉包，但光看字面根本猜不出意思。為了加深對 `closure` 的印象，而整理了這篇筆記。
<!--more-->

---

## 什麼是 Closure？

> 閉包是函式以及該函式被宣告時所在的作用域環境。

在讀到 MDN 為解釋閉包而舉的範例時，我產生了一個疑惑：巢狀函式可以取用上一層的變數，那是不是代表：**巢狀函式最內部的函式，也可以取用全域變數呢？**

接著繼續往下讀，看到這段對作用域的說明：
> 「作用域」一詞，指的正是作用域環境在程式碼指定變數時，使用 location 來決定該變數用在哪裡的事情。巢狀函式的內部函式，能訪問在該函式作用域之外的變數。

為了驗證我的疑惑，我寫了一段簡單的 code：
```javascript
var a = 123;
function outside(){
    console.log("from outside", a)
    return (function inside(){
        console.log("from inside", a)
    })()
}
outside(); 
```
得到的結果如下：
```javascript
from outside 123
from inside 123
```
我得到的結論就是，閉包是一個封閉的環境，外部宣告的變數可以傳入使用，內部宣告的變數無法被外部使用。

那麼再來的要問的就是，我什麼時候才會需要用到閉包？

---

## 閉包的使用時機？

簡單地說，當我需要在**當某事發生時觸發某個 function**，那閉包就相當實用。在此之前我最常用的方法是為一個 DOM 元素綁定 `eventListener`，再去觸發一個單獨宣告的 function。

這樣寫當然沒問題，不過若這個事件要觸發的內容需要多做一些運算，那可能就要宣告好幾個 function，除了要一直命名之外，四散的 code 也會增加除錯的複雜度（還有看 code 的爽度）。

了解閉包的特性之後，感覺對 JS 的理解又更深一層了。

---
參考資料：
* [MDN - 閉包](https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Closures)
* [胡立 - 所有的函式都是閉包：談 JS 中的作用域與 Closure](https://blog.techbridge.cc/2018/12/08/javascript-closure/)
* [從ES6開始的JavaScript學習生活](https://eyesofkids.gitbooks.io/javascript-start-from-es6/content/part4/closure.html)