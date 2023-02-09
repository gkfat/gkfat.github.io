---
title: Linux 學習筆記 - Systemd
tags: [Systemctl, Systemd, Linux]
---

有時難免會碰到網站掛掉，找到問題後發現是後端服務出錯的情況。身為純前端，這時通常會手足無措，因為必須等後端修復之後，才能回報 user。此時如果前端工程師能自行進入後端環境，做一些基本的偵錯處理，是否就能提升效率呢？

<!--more-->

---

## 初步理解 Systemd

Systemd 是一個 Linux 的系統與服務管理器。當你們家的網站是架設在 Linux 環境，最好還是熟悉一下 systemd 比較好。

關於 Systemd 的一些粗淺整理：
* 每一個系統服務稱為一個單元（unit）
* Unit 有很多種類型：系統服務（`.service`）、掛載點（`.mount`）、sockets（`.sockets`） 、系統設備（`.device`）、交換分割區（`.swap`）、檔案路徑（`.path`）、啟動目標（`.target`）、由 systemd 管理的計時器（`.timer`）
* 大部分的伺服器都屬於 `.service` 類型
* 可使用 `systemctl` 指令管理各項單元
* 所有可用單元的路徑如下：
```
// 軟體包安裝的單元
/usr/lib/systemd/system/

// 系統管理員安裝的單元（優先級更高）
/etc/systemd/system/
```

---

## `systemctl` 指令

Systemctl 指令的結構如下：
```
$ systemctl 操作指令 <單元>
```

### 0. 分析系統狀態
* <b>顯示系統狀態</b>
```
// 顯示系統狀態
$ systemctl status

// 顯示所有啟動中的單元
$ systemctl
// 或
$ systemctl list-units

// 顯示執行失敗的單元
$ systemctl --failed
```

### 1. 啟動／停止單元

* <b>啟動／停止單元</b>
```
// 啟動運行單元
$ systemctl start <單元>

// 停止運行單元
$ systemctl stop <單元>

// 重新啟動單元
$ systemctl restart <單元>
```


### 2. 查找單元


* <b>檢測系統單元狀態</b>
```
// 檢查單元狀態
$ systemctl status <單元>

// 檢查單元是否正在運行
$ systemctl is-active <單元>

// 檢查單元是否有設定開機自動啟動
$ systemctl is-enabled <單元>

// 檢查單元是否啟動失敗
$ systemctl is-failed <單元>
```

* <b>列出單元</b>
```
// 列出所有單元（包含已啟動／未啟動）
$ systemctl list-units --all

// 列出所有已啟動的單元
$ systemctl list-units

// 列出所有未啟動的單元
$ systemctl list-units --all --state=inactive

// 只列出系統上所有 service type 的單元
$ systemctl list-units --type=service
```

* <b>查看單元內部設定檔</b>
```
$ systemctl cat <單元>
```

### 3. 進一步設定單元

* <b>啟用、停用開機自動啟動單元</b>
```
// 啟用開機自動啟動單元
$ systemctl enable <單元>

// 停用開機自動啟動單元
$ systemctl disable <單元>
```

* <b>禁用特定單元</b>
```
// 禁用特定單元（禁用後就無法直接或間接啟動）
$ systemctl mask <單元>

// 取消禁用單元
$ systemctl unmask <單元>
```




---
參考資料：
* [ArchLinux - systemd](https://wiki.archlinux.org/index.php/Systemd_(%E6%AD%A3%E9%AB%94%E4%B8%AD%E6%96%87))
* [Linux命令大全 - systemctl命令](https://man.linuxde.net/systemctl)