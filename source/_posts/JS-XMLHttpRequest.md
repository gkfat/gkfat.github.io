---
title: JavaScript 學習筆記 - XMLHttpRequest
date: 2019-09-12 15:32:11
tags: [JavaScript,XMLHttpRequest]
---
學習程式以來碰到一個較難突破的關檻，就是「如何向 server 發送要求」。到目前為止常見的方法有三種：
* 用 jQuery 實現
* 用 fetch 實現
* 用 axios 實現
<!--more-->
但我的想法是想先了解背後的運作原理，以及用原生 JS 如何實現，之後再去使用方便快速的方法。

很多免費資源都可以在 YouTube 上搜尋到，例如這一個頻道： [Traversy Media](https://www.youtube.com/user/TechGuyWeb)，他在這支影片裡就帶著你用原生 JS 操作 XMLHttpRequest：[影片](https://www.youtube.com/watch?v=82hnvUYY6QA)


---

*XMLHttpRequest*
---
在了解如何操作之前，我想知道的是：
**「什麼是 XMLHttpRequest？它是為了什麼目的而存在的？」**

找了一些資料來看之後，這是定義：
> **XMLHttp 是一組能被 web 瀏覽器內嵌的 script 語言呼叫的 API，通過 Http 在瀏覽器和 web 伺服器之間收發 XML 或其它資料。其最大的好處在於可以動態地更新網頁內容。**

向伺服器發送一個 request，回傳資料後動態地更新網頁內容，對使用者而言，不用一直重複載入整個頁面，當然比較符合使用者體驗。

同時，XMLHttpRequest 也是實現 AJAX 重要的一環，在使用 asyncronous（非同步）技術來要求資料後動態更新網頁內容，讓使用者不須等待資料全部載完，就能夠先瀏覽網頁的其他內容，UX 因此更上一層。

但對現今的前端而言，AJAX 已經是必備技術，這也是我覺得必須盡快熟悉的原因。

---

*XMLHttpRequest 的屬性*
---

* `XMLHttpRequest.onreadystatechange`
在 `readyState` 屬性之狀態改變時被呼叫，可用於監聽 request 請求狀態的改變。

* `XMLHttpRequest.readyState`
回傳一個 0~4 之間的整數值，每個值代表的意義如下：

    |值|狀態|意義|
    |-|-|-|
    |0|`UNSENT`|客戶端已建立|
    |1|`OPENED`|`open()` 方法已被呼叫|
    |2|`HEADERS_RECEIVED`|`send()` 方法已被呼叫，且可取得 header 與狀態|
    |3|`LOADING`|回應資料下載中，此時 responseText 會擁有部分資料|
    |4|`DONE`|完成下載|
    > 本表格節自 [MDN：XMLHttpRequest.readyState](https://developer.mozilla.org/zh-TW/docs/Web/API/XMLHttpRequest/readyState)


* `XMLHttpRequest.status`
依據狀態不同，回傳介於 100~500 間的 HTTP status code，分別代表不同意義，例如代表成功回應的 `200 OK` 或廣為人知的錯誤 `404 Not Found`。
    > 更多狀態代碼請參照 [MDN：HTTP status code](https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Status)

* `XMLHttpRequest.responseText`
回傳一個 DOMString，其內容為請求之回應的文字內容。如請求失敗或尚未發送，則為 null。若確定 responseText 為 JSON 格式，通常會接著做 `JSON.parse()` 並接著處理資料。

---

*如何發送 XMLHttpRequest*
---
假設要發送一個簡單的 XMLHttpRequest 向伺服器要求資料，需要做到以下幾點來確保能夠成功返回資料。
* 建立一個 XMLHttpRequest
* 定義請求的方法（`GET` `POST` `PUT` `DELETE`...）
* 定義監聽流程
* 送出請求

用範例表示的話就是：
```javascript
let myFunction = function() {

    //創建 XMLHttpRequest
    let xhr = new XMLHttpRequest();
    
    //定義送出要求的網址
    let url = '<你想送出要求的網址>';
    
    //定義請求的方法
    xhr.open('GET', url, true);
    
    //定義監聽流程（當 status 改變時呼叫）
    xhr.onreadyStatusChange = function() {
    
        //顯示當前進度
        console.log('readyState', xhr.readyState, 'status', xhr.status)
        
        //確定請求成功時執行以下動作
        if ( xhr.status === 4 && xhr.readyState === 200 ) {
            //你想對回傳資料做些什麼？
            console.log(responseText);
        }
    }
    //送出請求
    xhr.send();
}
```

以上就是我目前了解到的發送 XMLHttpRequest 流程，以及每一步的意義。當然請求方法不只一種，XMLHttpRequest 也不會這麼單純，還有更多的細節需要處理。不過這部分就留待之後遇到再來研究如何解決吧。

---

#### 參考資料
* [維基百科：XMLHttpRequest](https://zh.wikipedia.org/wiki/XMLHttpRequest)
* [MDN：XMLHttpRequest](https://developer.mozilla.org/zh-TW/docs/Web/API/XMLHttpRequest)
* [MDN：XMLHttpRequest.readyState](https://developer.mozilla.org/zh-TW/docs/Web/API/XMLHttpRequest/readyState)
* [MDN：HTTP status code](https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Status)