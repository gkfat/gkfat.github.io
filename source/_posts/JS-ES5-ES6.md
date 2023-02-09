---
title: JavaScript 學習筆記 - ES5 vs ES6
date: 2019-09-12 15:36:26
tags: JavaScript
---
學習 JavaScript 一段時間了，也逐漸熟悉各種語法的運用，覺得差不多可以更深一層地認識這個語言了。因此趁此機會，就來整理一篇筆記，探討 `ES5` 與 `ES6` 之間的差異。
<!--more-->
---

*定義*
---

網路上對於 `ES5` `ES6` `ECMA2015` `ECMAScript` `JavaScript` 的定義眾說紛紜，剛接觸 JS 的時候我也看得一頭霧水。直到後來看到這篇文章，讓我在一團亂中理清了一絲思緒。
> [一文讀懂 JavaScript 與 ECMAScript 的區別](https://www.oschina.net/translate/whats-the-difference-between-javascript-and-ecmascript)

根據上文，我可以清楚地定義，我想了解的是 `ES5(ECMA2009)` 與 `ES6(ECMA2015)` 之間的差異，也就是新版本究竟做了哪些改動。

---
*ES5 與 ES6*
---
首先是 JavaScript 的特性，也就是初學者(*也就是我)開始學習 JavaScript 時，最先學習到的基礎部分。這裡就不特別區分 ES5 才新增的語法了。

* 變數宣告：`var`
* 流程控制：`if...else` `for` `while` `switch`
* 嚴格模式：`'Use Strict'` 
* 陣列操作：`every / some / forEach / filter / indexOf / map / reduce` ...等方法
* 資料操作：`JSON.parse()` `JSON.stringify()`
* `Object` 方法
* 操作 `DOM` `BOM`

再來是 ES6 新增的部分。

* 變數宣告：`let` `const`
* 字串模板：以 `` 包覆的 html 內容，動態內容則直接寫在 `${}` 內部
* 解構賦植
* 箭頭函示：`() => {}`
* `Class`
* `Modules`
* `Promise`


---
*總結*
---

ES6 新增的語法，目前使用得比較熟練、也明白特性的大概就變數宣告、箭頭函式、字串模板。其他的新語法，還有待練習。之後再來寫筆記整理對這些語法的認識吧。

---
#### 參考資料
* [一文讀懂 JavaScript 與 ECMAScript 的區別](https://www.oschina.net/translate/whats-the-difference-between-javascript-and-ecmascript)
* [「譯」ES5, ES6, ES2016, ES.Next: JavaScript 的版本是怎麼回事？](https://huangxuan.me/2015/09/22/js-version/)
* [JavaScript、ES5和ES6的介绍和區别](http://caibaojian.com/toutiao/6864)