---
title: Web 學習筆記 - localStorage / sessionStorage / cookie / session 比較
date: 2019-09-12 17:36:01
tags: [web,localStorage,sessionStorage,cookie,session]
---

這幾個東西有什麼不同？這是面試很常出現的基礎題，也是前端新手（*例如我）很容易霧煞煞的部分。為了加深印象，我決定來整理一篇筆記。
<!--more-->
在找資料的過程中，發現一個叫做 `session` 的東西，與 `cookie` 放在一起討論。這解釋了我其中一場面試的疑惑，當我在討論`localStorage` 與 `sessionStorage` 時，面試官卻說「`session` 應該是存在伺服器端的才對」，並且提到了 `cookie`。

原因在這裡，我們講的是不同東西啊！面試官嘴裡說的是 `sessionStorage`，心裡想的卻是 `session`。

真抱歉，我又不會通靈。

---

`localStorage` 與 `sessionStorage`
---
### 相同特徵
* 儲存大小限制皆為 5MB 左右
* 都有同源策略（CORS）限制
* 僅在客戶端瀏覽器中存在

### 相異特徵
||localStorage|sessionStorage|
|-|-|-|
|生命週期|永久儲存在瀏覽器中，除非人為刪除|瀏覽器或標籤頁關閉時自動刪除|
|作用域|在同一個瀏覽器内，同源文件間共享，可互相讀取、覆蓋|因生命週期關係，僅在同個瀏覽器、同個標籤頁內的同源文件間才可共享|

### 操作方法
```javascript
//sessionStorage用法相同
localStorage.setItem();     // 儲存一個物件
localStorage.getItem();     // 獲取物件內容
localStorage.key();         // 獲取第i個物件
localStorage.removeItem();  // 刪除一個物件
localStorage.clear();       // 全部删除
```
透過上述的方法，就能夠將使用者的一些資料（例如搜尋字串等）儲存在該使用者的瀏覽器中，當下次再訪問這個網站時，就能夠使用這些資料來提升使用者體驗。

---

`cookie` 與 `session`
---
### `cookie`
* 大小限制只有 4KB 左右
* 通常會帶有使用者的 `sessionID` 供伺服器辨識
* 由伺服器產生後保存在客戶端，可以設定多久失效
* 每次都攜帶在 HTTP header 中

### `session`
* 保存在伺服器端
* 存有使用者的敏感資料

### `cookie` 與 `session` 的溝通
當使用者訪問網站、通過身份認證後，伺服器端會送出一個 `cookie` 到客戶端，並建立一個 `sessionID` 存在 `cookie` 中。之後使用者只要通過該網站的身份認證，就能夠透過存在 `cookie` 中的 `sessionID` 查找到存在伺服器的 `session` 資料。

---

參考資料

* [细说localStorage, sessionStorage, Cookie, Session](https://juejin.im/entry/5ac4d661f265da23a049c92a)
* [介紹 Session 及 Cookie 兩者的差別說明](https://blog.hellojcc.tw/2016/01/12/introduce-session-and-cookie/)