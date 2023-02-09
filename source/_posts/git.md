---
title: Git 學習筆記 - 如何使用 Git 做版本控制
date: 2019-10-24 22:16:32
tags: git
---
身為一位工程師，版本控制的重要性就應該刻在你的靈魂深處。不做版控，表示你必需冒著風險修復更動程式碼之後出現的 bug，也代表你的網站被攻擊之後，沒辦法恢復到原來的狀態。

<!--more-->

所謂版本控制不只是備份專案，更主要的是將專案切成小塊，透過版本紀錄，可以清楚知道專案的進度、每一個版本改動了哪些東西、程式碼之間的差異。

總而言之，版控是一定要的。

---

## 使用 Git 的流程

因為 `git` 相當博大精深，指令超多，我們在一般專案操作及協作上，有個基本的認知的就可以了。平常用到的都是基本功能，哪天遇到奇怪的狀況，再查資料想辦法解決就好了。

那麼，開始吧！

### 配置 git

> 先安裝才能使用啊：[Git 安裝教學](https://git-scm.com/book/zh-tw/v2/%E9%96%8B%E5%A7%8B-Git-%E5%AE%89%E8%A3%9D%E6%95%99%E5%AD%B8)

```bash
# 顯示目前的 git 配置
$ git config --list

# 設定使用者
$ git config user.name "GK"
$ git config user.email "gk@fat.com"
```

### 產生 git 目錄

開始寫扣之前，先產生一個 `git` 目錄。有人習慣用 sourcetree，也可以，但我比較喜歡用 command line 敲指令，因為這樣比較帥（喂）。

```bash
# 產生專案資料夾
$ mkdir myProject

# 移動到專案目錄
$ cd myProject

# 初始化 git
$ git init

# 看到這條訊息，表示成功 init 了
Initialized empty Git repository in 你的專案目錄/myProject/.git/
```

### Commit 流程

現在有了 `git`，可以開始做版本控管了。那麼先來看看目前是什麼情況吧。

```bash
$ git log
fatal: your current branch 'master' does not have any commits yet
```

因為你還沒做過任何 commit，所以 `master` 主支目前是空的狀態。讓我們來試著 commit 一下。

```bash
# 將檔案添加到暫存區
$ git add .

# 將暫存區提交到倉庫
$ git commit -m "First Commit"
On branch master
Initial commit
nothing to commit
```

結果因為沒有任何檔案，所以不讓你 commit。

好啦，開始寫扣囉。

專案進行到一個階段後，到達設定的里程碑了，打算來更新版本。假設實作好了「新增／刪除產品」的功能，此時先用上個步驟的添加文件，把進度加到暫存區，然後將暫存區提交到倉庫，完成一個版本更新。

```bash
# 將檔案添加到暫存區
$ git add .

# 將暫存區提交到倉庫
$ git commit -m "Update Add Product Features"

# 假如你發現 commit message 打錯了想要更改，可以這樣改寫最後一次的 commit
$ git commit --amend -m "Update Add & Delete Product Features"

# 如果後悔了，想要撤銷暫存區的檔案，恢復到工作區
$ git checkout .
```

`-m` 後面那一串代表的是這次版本更新攜帶的訊息，方便之後 `git log` 時查看，這邊推薦使用英文，方便查詢。

或許你會想知道能不能修改更早之前的 commit，答案是可以，只是你需要先移動到該次 commit，再用上面那招更改。

### 增加／刪除文件

不一定每次都要把全部更動的文件加到暫存，可以一次只加一個文件／資料夾。這樣，還沒做好的檔案就可以繼續保持狀態，而更新過的檔案就讓他進去 commit。

```bash
# 添加目前目錄的所有文件到暫存區
$ git add .

# 添加指定文件到暫存區
$ git add [fileName]

# 刪除指定文件，並把刪除的動作加入暫存區
$ git rm [fileName]

# 停止追蹤文件，但不刪除文件
$ git rm --cached [fileName]
```

### 分支的操作

分支 `branch` 非常方便，你可以想像把一整份項目的檔案全部拷貝出來，修改完其中一個部分，並確定能正常執行後，再合併回去項目本身，這就是分支的概念。

特別是當多人協作的時候，每個人都可以從特定的版本去拷貝一份出來，進行自己那部份的修改，再合併回去。

```bash
# 列出所有本地分支
$ git branch

# 從當前分支新增一個分支，但停留在當前分支
$ git branch [newBranch]

# 新建一個分支並切換過去
$ git checkout -b [newBranch]

# 切換到指定分支，同時更新工作區
$ git checkout [branchName]

# 合併指定分支到目前分支
$ git merge [branchName]

# 刪除分支
$ git branch -d [branchName]
```

### 其他操作

```bash
# 顯示目前分支的版本歷史
$ git log

# 查詢 commit 歷史
$ git log -S [keyword]
```

---

## 遠程協同作業

上面是在本地端操作 `git` 的部分，那今天當多人要協作時，又是什麼情況呢？假設今天選用的遠端倉庫是 GitHub。

### 與 GitHub 連動

> 直接看保哥的教學比較快：[第 25 天：使用 GitHub 遠端儲存庫 - 觀念篇](https://github.com/doggy8088/Learn-Git-in-30-days/blob/master/zh-tw/25.md)

```bash
# 新增一個遠端倉庫
$ git remote add [shortName] [url]

# 下載一個遠端倉庫的完整 git 歷史
$ git clone [url]

# 下載遠端倉庫的所有變動
$ git fetch [remote]

# 下載遠端倉庫的所有內容，並將遠端的 origin/master 合併到本地 master
$ git pull

# 將本地的所有變動與歷史推送到遠端倉庫
$ git push
```

以上就是我常用的 `git` 指令。如果想對 `git` 有更深入的理解（其實我還有很多不懂的地方），就繼續找資源來鑽研吧！

---
參考資料：
* [Git 安裝教學](https://git-scm.com/book/zh-tw/v2/%E9%96%8B%E5%A7%8B-Git-%E5%AE%89%E8%A3%9D%E6%95%99%E5%AD%B8)
* [30 天精通 Git 版本控管](https://github.com/doggy8088/Learn-Git-in-30-days)