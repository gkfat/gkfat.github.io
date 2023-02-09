---
title: JavaScript 學習筆記 - Prototype 與 Class
date: 2019-09-18 16:18:31
tags: [JavaScript, class, prototype]
---

我認為這兩個概念放一起討論會比較好融會貫通，因此整理成同一篇。關於為什麼 JS 需要有繼承與原型鏈，網路上有很多文章在說明緣由，我就不再贅述了。
<!--more-->

---

## 物件？類別？實例？

首先，我們對 JS 的理解就是「這是一個物件導向的語言」。

由於我是非本科，對物件導向的概念其實並不了解，因此看了一些文章之後，總結出下列定義：

**「物件（Object）就是類別（Class）的實例（Instance）」**

那麼問題來了。什麼是類別？什麼又是實例？

### 類別（Class）與物件（Object）

類別，是定義一件事物的抽象特點。

例如定義一個「人的類別」，可能會有年齡、姓名、生日、身分證字號、聯絡電話、住址...等等特徵。

物件，就是產生出一個符合這個類別的實例。

例如：
```javascript
{
    姓名： 小明,
    年齡： 18,
    聯絡電話： 0912345678,
}
```

小明就可說是一個「人」的類別的實例。

---

## JavaScript 其實沒有真正的 `Class`

這是一個有點令人混淆的觀念。我們既說 JS 是物件導向的語言，但他又沒有真正的 Class，那 JS 的物件到底是怎麼建立的？不是基於 Class 嗎？

### JavaScript 的類別（Class）

`Class` 其實是一種宣告函式的語法。但並不像函式一樣會 hoisting，因此順序很重要。若要使用 `Class` 來建立 `Object`，你需要先宣告 `Class`，才能取用他。下面這個例子就會拋出錯誤：
```javascript
var p = new Person(); // ReferenceError
class Person {};
```

一個 `Class` 中只能有一個建構子（constructor），否則會報錯。`constructor` 是用來建立和初始化一個類別的物件。

在 `Class` 中除了 `constructor` 之外，還可以宣告這個類別的 `methods`。例如我可以說：
```javascript
class Person {
    constructor(name, age){
        this.name = name;
        this.age - age;
    }
    talk() {
        console.log('Hello! I'm ' + this.name);
    }
}
var ming = new Person('小明', 25); // 宣告一個叫小明的實例
```

但是正如前文提到的，`Class` 並不是真正的在宣告類別。以下引用自[Summer。桑莫。夏天](https://cythilya.github.io/2018/10/28/es6-class/)，說明 `Class` 的真相：
> Class 依舊是利用 [[Prototype]] 委派機制來實作的，它只是個語法糖而已，也就是說，Class 並非如其他物件導向語言般在宣告時期靜態的複製定義，而只是物件間的連結，因此若不小心變更了父類別的方法或屬性，子類別與其實體都會受到影響。

既然知道了 `Class` 就是個方便宣告類別的工具之後，接著就要來理解 `prototype` 的概念了。

---

## JavaScript 的 `prototype`

我讀到一個比較好理解 `prototype` 的說法。先回到 `Class`，假設你一次宣告了 10 個 `Person`，此時雖然他們的 `name` 與 `age` 都不同，但每個 `Person` 都有一個重複的 `talk()` method。這樣是不是有點佔用資源了？

這時可以把 `talk()` 指定到 `Person.prototype` 上面，讓所有 `Person` 的 instance 都可以使用這個方法。

從另一個角度來看，可以從 `Person.prototype` 去找到底下的 `Person`，這就是原型鏈的概念。

## 什麼是 `__proto__` ？

用結論來說，`__proto__` 就是 instance 往 parent 尋找的方法。

例如尋找 `ming.__proto__`，就會找到 `Person`。

---
參考資料：
* [物件導向(Object Oriented Programming)概念](https://medium.com/@totoroLiu/%E7%89%A9%E4%BB%B6%E5%B0%8E%E5%90%91-object-oriented-programming-%E6%A6%82%E5%BF%B5-5f205d437fd6)
* [MDN - 繼承與原型鏈](https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Inheritance_and_the_prototype_chain)
* [TechBridge 技術共筆部落格 - 該來理解 JavaScript 的原型鍊了](https://blog.techbridge.cc/2017/04/22/javascript-prototype/)
* [JS原型鏈與繼承别再被問倒了](https://juejin.im/post/58f94c9bb123db411953691b)
* [從ES6開始的JavaScript學習生活](https://eyesofkids.gitbooks.io/javascript-start-from-es6/content/part4/prototype.html)
* [你懂 JavaScript 嗎？#21 ES6 Class](https://cythilya.github.io/2018/10/28/es6-class/)