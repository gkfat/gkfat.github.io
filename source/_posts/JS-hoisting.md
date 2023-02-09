---
title: JavaScript 學習筆記 - hoisting
date: 2019-09-15 21:57:53
tags: [JavaScript, hoisting]
---

JavaScript 這語言在某些時候並不是很嚴謹，所以特別去了解那些奇怪的部分，能夠大幅減少莫名其妙卡住的除錯時間。
<!--more-->

---

## 什麼是 hoisting？

我們都知道，JS 是一個單線程語言，這也就是說，瀏覽器在讀 code 時，是一行一行讀下來的。那麼：
1. 宣告變數
2. 使用變數

按照邏輯，一定要按照這個順序，才能正常 working，對吧？舉個例子：
```javascript
var a = 100;
console.log(a); //100
```

那麼，這樣寫會印出什麼呢？
```javascript
console.log(a); //print?
var a = 100;
```

很簡單嘛！你說。根據你學過的 JS，這個變數還沒有被宣告，所以無法使用，所以會印出 `ReferenceError: a is not defined`。

結果一打開 console，嚇死人了！居然跑出 `undefined`。這代表的是， `a` 這個變數已經被宣告了，但還沒有被賦值。沒有值這一點很容易理解，畢竟你在賦值以前就使用它嘛，這很正常。但變數宣告 `var a;` 的部分居然被提到前面來了！？

這就是 `hoisting`，提升的概念。

那麼，再進一步。不只變數會 `hoisting`，function 也會，而且 function 會優先於變數。用例子來看的話就是像這樣：
```javascript
console.log(a);
var a;
function a(){}; 
```

console 會印出什麼？
答案是 `Function: a`。

---

## ES6 的 hoisting

如果你跟我一樣，對 JavaScript 已經有一定熟悉度但還沒熟透，你可能會知道 ES6 新增的變數宣告方法 `let` 與 `const`，可能也會有個模糊的概念：這兩個宣告方法沒有 `hoisting`。

我原本也是這樣想的，直到讀到這一篇文章：[TechBridge - 我知道你懂 hoisting，可是你了解到多深？](https://blog.techbridge.cc/2018/11/10/javascript-hoisting/)

> 這篇文章完整提到 (1)什麼是hoisting？ (2)為什麼我們需要 hoisting？ 以及 (3)hoisting是怎麼運作的？建議各位好好閱讀一下，真的可以理清很多事情。

結果 `let` 跟 `const` 還是有 `hoisting` 的，只是行為跟 `var` 不同。

---
參考資料：
* [TechBridge - 我知道你懂 hoisting，可是你了解到多深？](https://blog.techbridge.cc/2018/11/10/javascript-hoisting/)
* [MDN - Hoisting](https://developer.mozilla.org/zh-TW/docs/Glossary/Hoisting)
* [JavaScript: 变量提升和函数提升](https://www.cnblogs.com/liuhe688/p/5891273.html)
* [Hoisting in JavaScript](https://john-dugan.com/hoisting-in-javascript/)