---
title: Vue.js 學習筆記（一）
date: 2019-06-26 21:24:41
tags: vue.js
---
從頭開始學習 Vue.js，這真的是個很方便的東西。因為是記錄給自己看的，比較不會太詳細或有系統，也不知道會有幾篇XD。如果你想更進一步學習 Vue，建議你上網找課程，或閱讀 Vue 的官方文件。

<!--more-->

*導入 Vue.js 的方法*
---
在 `<head></head>` 內新增下列這一行程式碼，即可透過 CDN 引入 Vue.js。
```javascript
<script src="https://cdn.jsdelivr.net/npm/vue"></script>
```

至於如何透過 `npm` 來安裝，以及官方所謂的腳手架工具，目前還不是很了解。

---

*Vue 的基本環境創建*
---
需先在 `<html>` 內創建一個掛載點，簡單的寫法如下：
```javascript
<body>
    <div id="app"></div>
</body>
```
這個 `<div>` 就是 Vue 透過 id 抓到的的掛載點（也可以透過 class 來綁定，但沒辦法用同個 class 建立兩個 Vue，只會出現一個），接下來在`<script></script>` 內新增一個 Vue 如下：
```javascript
<script>
    var app = new Vue({
      el: "#app"  //透過id抓取此掛載點
      //此處撰寫 Vue
    });
</script>
```

這樣一個基本的 Vue 環境就建置完成了。

另外補充一個點，在 `Vue();` 的內部，是用物件來撰寫資料的，這也是為什麼會需要用大括號包起來。

---

*Vue 基本功能*
---

### 一、條件判定渲染

`v-if` `v-else-if` `v-else` 使用條件來判定是否要渲染內容。若只依單一情況判定是否渲染，那可以用 `v-show` 就好。

可以單獨使用如下：
```javascript
<p v-if="isAwake">我醒著</p>  //isAwake=true 則渲染這塊內容
```
也可以搭配使用如下：
```javascript
<p v-if="isAwake">我醒著</p>  //isAwake=true 則渲染這塊內容
<p v-else>我睡死了</p> //isAwake=false 則渲染這塊內容
```
三者同時混用如下：
```javascript
<p v-if="num===1">This is 1</p>
<p v-else-if="num===2">This is 2</p>
<p v-else-if="num===3">This is 3</p>
<p v-else>This is not 1/2/3</p>
```

### 二、列表渲染

`v-for` 可以達到節省重複撰寫 `<li>` 的效果。

舉例 `<html>` 中要重複渲染的區塊如下：

```javascript
<ul id="app1">
  <li v-for="item in items">  //或 item of items
    {{ item.content }}
  </li>
</ul>
```

在 `Vue` 的 `data.items` 中列出所有內容，就可以做到重複渲染，如此一來相當方便管理。

### 三、事件監聽

`v-on` 可以方便地監聽 DOM 的各種事件，`v-on` 亦可以用 `@` 取代。簡單舉例如下：

```javascript
<button v-on:click="myFunction">按鈕</button>
<button @click="myFunction">按鈕</button>  //偷懶的縮寫
```

### 四、屬性綁定

`v-bind` 將 DOM 元素綁定一個 class。

```javascript
<div v-bind:class="myClass"></div>
<div :class="myClass"></div>  //偷懶的縮寫
```
或綁定 src，讓你能更動態地改變這個 DOM 元素的來源。
```javascript
<img v-bind:src="imageSrc" />
<img :src="imageSrc" />  //偷懶的縮寫
```

屬性綁定還能夠更方便地操作 DOM，之後再來探討。

### 五、修飾符

Vue 的修飾符分為兩種：
* 事件修飾符
* 按鍵修飾符

接下來就簡短記錄一下。

#### （一） 事件修飾符

有時為了預防假按鈕 `<a>` 點擊事件時，觸發到 `<href="#">` 的跳轉或冒泡，我們會使用 `preventDefault()` `stopPropagation()` 來處理。在 Vue 中其實也差不多意思。

* `.stop`
* `.prevent`
* `.capture`
* `.self`
* `.once`
* `.passive`

隨便舉個例子，可以這樣寫：
```javascript
<a href="#" v-on:click.stop="myFunction">假按鈕</a>
```

#### （二） 按鍵修飾符

我們常為了監聽按鍵的行為而寫下許多 `addEventListener`，按鍵修飾符可以說就是簡化這件事的幫手。而且 Vue 還貼心地將按鍵對應的 keycode 轉變成直覺式的命名：

* `.enter`
* `.tab`
* `.delete`
* `.esc`
* `.space`
* `.up`
* `.down`
* `.left`
* `.right`

舉個例子，這樣用：
```javascript
<input v-on:keyup.enter="submit">
```

Vue 真的是很方便呢！

---

*Vue 觀念*
---

### 綁定的觀念

在 Vue 中很重要的一個觀念就是綁定。透過綁定，讓 DOM 的操作變得容易。

而透過 `v-model` 的雙向綁定，讓使用者輸入的內容，能夠同步修改 Vue 中的數據，如此一來能應用的範圍就很廣了。

舉個例子，我有下列這段 `<html>`：
```javascript
<div id="app">
    勇者名稱： {{ name }}
    <input type="text" v-model="message" />
    <button v-on:click="enterName">點我來輸入勇者名稱</button>
</div>
```
在這個範例中，我希望使用者在 `<input>` 中輸入名稱，並點擊按鈕後，觸發 `enterName()` 將名稱傳入 `message`。如果是用純 js，我需要創建一個新的 `html` 標籤，並抓取 `<input>` 的 value 傳入，這期間又會需要做一些宣告變數來抓取各個標籤的動作，相當繁瑣。但在 Vue 中我只需要這樣寫：

```javascript
var app = new Vue({
    el: "#app",
    data: {
        message: "請輸入勇者姓名", //直接當作 input placeholder
        name: ""  //宣告空的 name
    },
    methods: {
        enterName: function(){
            //直接將 messgae 傳入 name
            this.name = this.message;
        }
    }
});
```
就完成了！非常方便。這就是 Vue 偉大的綁定概念。

---

需進一步了解的部分
---

* App.vue：template + script + style
* component
* Vue 腳手架