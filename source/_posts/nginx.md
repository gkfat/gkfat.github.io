---
title: Nginx 學習筆記 - 使用 Nginx 
date: 2019-10-24 22:15:35
tags: nginx
---
最近被主管要求使用 `Nginx` 來放專案的測試版本，方便跟 PM 溝通（就不用一直叫 PM 過來看我表演 `ng serve`，直接 build 好丟網址給他就可以測試了）。原本以為 `Nginx` 安裝一下改個 `config` 很方便，結果還是在意想不到的地方卡了一下，因此整理成筆記分享，以免有人遇到相同的問題。

<!--more-->

---

## 安裝 `Nginx`

> 安裝起來先：[Nginx 官網](http://nginx.org/en/docs/install.html)

因為我是用 Mac，所以直接開啟 Terminal 輸入：
```bash
$ brew install nginx
```

---

## 指令

```bash
# 啟動
$ sudo nginx

# 更新
$ nginx -s reload

# 停止
$ sudo nginx -s stop
```

打開 http://localhost:8080，就會看到 `Nginx` 在跟你招手了！

---

## 配置

我們當然不可能滿足於用 localhost:8080，所以現在要來改配置。

先找到 `nginx.conf` 檔，Mac 的檔案位置如下：

```
/usr/local/etc/nginx/nginx.conf
```

開啟 `nginx.conf` 檔之後，找到下面這個區塊：

```nginx
server {
    listen 8080 default_server;
}
```
改為下面這樣子：

```nginx
server {
    listen 80 default_server;
}
```

這樣，`Nginx` 就會在你的 `localhost`（或你電腦的 ip 位址）執行了。

---

## 根目錄

localhost 預設會打開的檔案如下：

```nginx
server {
    listen 80 default_server;
    # listen [::]:80 default_server ipv6only=on;
    server_name localhost;
    root /usr/local/Cellar/nginx/1.17.3_1/html; # 預設根目錄
    index index.html; # 預設開啟的檔案
}
```

那麼，接下來就可以來設定各個路由會通往哪裡了：

```nginx
server {
    location / {
        # 因為是空的，會去找 server 的預設路徑
    }
    
    # 設定 localhost/my-website/
    location /my-website/ {
        alias /Users/user/desktop/myProject/; # 設定檔案目錄的路徑
        index index.html; # 要開啟的檔案
    }
}
```

如果訪問 `localhost/my-website/`，就會去開啟 `myProject` 專案底下的 `index.html` 檔了。耶！

---

## 權限問題

不曉得是什麼原因，我在訪問網址的時候，`localhost/` 可以正常顯示，但 `localhost/my-website/` 卻一直出現 `403 forbidden`。找了各種可能的原因後，最後判斷應該是因為訪問者的權限不足，因此不能訪問檔案。

因此在 `nginx.conf` 的第一行，調整訪問者的權限：

```nginx
# 原本是這樣，也是註解的狀態
# user nobody

# 把註解打開，並改成這樣
user root owner;
```

就可以訪問各個路徑了。

只是不曉得對方拿到 root 權限，可以對你的網站做什麼事，一顆心撲通撲通地亂跳。但反正用 `Nginx` 來架站，我目前僅用於公司內部測試用，就暫時不擔心這個問題啦。

好了，以上就是感覺充滿坑的 `Nginx` 架站筆記。


---
參考資料：
* [Nginx 官網](http://nginx.org/en/docs/install.html)
* [Installing Nginx in Mac OS X Maverick With Homebrew](https://medium.com/@ThomasTan/installing-nginx-in-mac-os-x-maverick-with-homebrew-d8867b7e8a5a)