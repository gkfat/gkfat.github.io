---
title: 使用 Hexo + Github 來架設個人部落格
date: 2019-06-25 20:28:29
tags: hexo
---
最近強烈感受到寫技術筆記的需要，因此花費幾天的時間研究 Hexo，並且把這個站給架起來。雖然我本身也有其他的部落格，但程式還是歸程式，感覺比較能專心寫。
<!--more-->
*安裝 Hexo*
---
先確定有安裝 **node.js & git**，再依官網步驟安裝 **Hexo**。
```javascript
$ npm install -g hexo-cli
 ```
在做上面這步驟時，我遇到權限不足的問題卡了很久，後來照以下步驟就解決了。雖然很多人推用 sudo 解決，但更多人建議不要使用 sudo，好像很容易造成不可挽回的錯誤，於是我就沒用了。

[解法如下，來源請點此](https://github.com/hexojs/hexo/issues/2695)
```javascript
$ npm config set user 0
$ npm config set unsafe-perm true
$ npm install -g hexo-cli
```
就成功安裝 **Hexo** 了，真是可喜可賀！

---

*選擇主題 themes*
---
部落格最重要的門面，當然不能隨便決定啊！雖然要換很快啦，但我還是選了一陣子。最後決定使用滿多人使用的 **NexT**。

[NexT 的官方 Github](https://github.com/theme-next/hexo-theme-next)

輸入下面這行來把 **NexT** 資料搬下來：
```javascript
$ git clone https://github.com/theme-next/hexo-theme-next themes/next
```
就會自動下載主題並在 **themes** 資料夾底下創建 **next** 資料夾了，主題所需的東西都在裡面，接下來只要在 **_config.yml** 中將 **theme** 改為該主題名稱，像這樣：
```javascript
theme: next
```
就可以成功套用主題了！嗚拉拉

---

*發佈一篇文章 Post*
---
### 一、確認 Hexo 已正確啟動
```javascript
$ hexo -v
```
如果有正確啟動 **Hexo**，會跑出版本說明，這時可以放心繼續下去。

### 二、新增一個 post

（一）新增發文
```javascript
$ hexo new "new post name"
```
new post name 也可以是中文喔。

會在 **source/_posts** 目錄底下新增一個 **日期_new_post_name.md** 文件，此時就可以進去編輯你的新文章了。

（二）新增草稿
```javascript
$ hexo new draft "new draft name"
```
會在 **source/_drafts** 目錄底下新增一個 **日期_new_draft_name.md** 文件，寫完可以用這個命令來發佈：
```javascript
$ hexo publish [layout] <filemame>
```
（三）更新 **Hexo**

上述兩步都只是在 **source** 資料夾中更新文章而已，你還需要這個步驟才能更新 **Hexo**：
```javascript
$ hexo generate  //或 hexo g
```
### 三、推上 github

（一）更改 **_config.yml** 內容

為了將 **Hexo** 與 **Github** 連結起來，你需要在 **_config.yml** 中填入相關資料。

```javascript
url: https://<你的 github name>.github.io/<你的 repository name>/
root: /<你的 repository name>/
```
```javascript
deploy:
  type: git
  repo: <你的 repository url>
```
（二）安裝 **Hexo-git-deployer**

```javascript
$ npm install hexo-deployer-git --save
```

（三）執行部署

以下三種命令都會將 **Hexo** 部署上去，其中的 **generate** 就是直接幫你把更新 **Hexo** 也一併做了。

```javascript
$ hexo deploy --generate
```
```javascript
$ heso generate --deploy
```
```javascript
$ hexo g -d
```

---

關於個人部落格的架設就寫到這邊，算是流程的紀錄，也希望之後能幫到遇到一樣的問題的人，感覺 **Hexo** 還有很多坑等著讓人踩啊。