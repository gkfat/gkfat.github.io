---
title: Web 學習筆記 - HTTP
date: 2019-12-22 16:30:14
tags: [http]
---

HTTP（`HyperText Transfer Protocol`）可說是學習 Web 知識的基本，不僅如此，他還是基本中的基本。因為接著要接觸到 `WebSocket`，必須先加深網路基礎知識，才能一步步攻破。

<!--more-->

---
## `HTTP` 是什麼？

首先要了解的是 `HTTP` 究竟是什麼碗糕？

> HTTP（超文本傳輸協定）是一個用戶端（用戶）和伺服器端（網站）之間請求和應答的標準，通常使用 TCP 協定。

也就是說，這是一種溝通標準，用來實現用戶與伺服器間的連接。只要依循這個標準，就能夠實現與伺服器間的互動。

實際的流程會像這樣：
* 用戶端發出一個請求
* 與伺服器指定埠建立 TCP 連接
* 伺服器收到請求，會返回狀態（例如 `200 ok`）及資源（請求的檔案..etc）
* 用戶端收到狀態與資源

### `HTTP` 請求方法

`HTTP` 協定中定義了數種請求的方法，而程式新手（e.g. Me）最常使用到的就是以下四種：

|方法|用途|
|-|-|
|`GET`|向伺服器送出「讀取資料」的請求|
|`POST`|向伺服器送出「提交資料」的請求|
|`PUT`|向指定的資源上傳「最新資料內容」|
|`DELETE`|請求伺服器刪除指定的資源|

### 伺服器返回狀態碼

伺服器返回的狀態碼依據開頭的數字不同，代表著不同的狀態。以下是一個共通的類別，至於細項可以參考：[Http 狀態碼](https://zh.wikipedia.org/wiki/HTTP%E7%8A%B6%E6%80%81%E7%A0%81#1xx%E6%B6%88%E6%81%AF)

|狀態碼|代表狀態|
|-|-|
|`1xx` 訊息|請求已被伺服器接收，繼續處理|
|`2xx` 成功|請求已成功被伺服器接收、理解、並接受|
|`3xx` 重新導向|需要後續操作才能完成這一請求|
|`4xx` 請求錯誤|請求含有詞法錯誤或者無法被執行|
|`5xx` 伺服器錯誤|伺服器在處理某個正確請求時發生錯誤|

一般前端要操作 `Ajax`，會用 `if` 來判斷回傳的狀態是否為 `200`，是的話再做其他操作。

```javascript
if ( xhr.status === 200 ) {
    //確定伺服器收到請求並處理了，繼續在本地做一些操作
} else {
    console.log("錯誤發生啦！狀態碼為: ", xhr.status)
}
```

### `HTTP Request Header`

`HTTP Request Header` 能夠在送出 `HTTP` 請求時，向伺服器明確闡述請求的類型。有些時候是必要的，例如向伺服器進行使用者的身份認證（`Authorization`），或設定跨來源資源共用（`CORS`）等等。 

設定 `Header` 的方法：
```javascript
xhr.setRequestHeader(<header>, <value>);
```

### 跨來源資源共用（`Cross-Origin Resource Sharing`）

對像我這樣的前端入門者而言，這是一個令人頭痛的問題。簡單來說，如果你今天向不同網域提供的 API 送出請求，此時就會產生一個跨來源 HTTP 請求（`cross-origin HTTP request`）。

這代表什麼呢？除非提供資源的那一方，在回傳的回應裡有帶到寫著 `Access-Control-Allow-Origin` 或 `*` 的 `response header`，否則這會被瀏覽器判斷為一個跨來源的請求，而被擋下。

關於 `CORS`，是個前端工程師必須面對的經典議題。但由於（不是魷魚）小弟我對 `CORS` 的認識也僅限於上述那麼淺白的程度，還沒辦法做個很好的解釋，因此就請各位自行參考網上大大們寫的文章了。


---
參考資料：
* [MDN - HTTP](https://developer.mozilla.org/zh-TW/docs/Web/HTTP)
* [Wiki - 超文本傳輸協定](https://zh.wikipedia.org/zh-tw/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE)
* [HTTP狀態碼](https://zh.wikipedia.org/wiki/HTTP%E7%8A%B6%E6%80%81%E7%A0%81#1xx%E6%B6%88%E6%81%AF)
* [跨來源資源共用（CORS）](https://developer.mozilla.org/zh-TW/docs/Web/HTTP/CORS)
* [原來 CORS 沒有我想像中的簡單](https://blog.techbridge.cc/2018/08/18/cors-issue/)
* [輕鬆理解 Ajax 與跨來源請求](https://blog.techbridge.cc/2017/05/20/api-ajax-cors-and-jsonp/)