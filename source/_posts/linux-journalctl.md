---
title: Linux 學習筆記 - Journalctl
tags: [Journalctl, Systemd, Linux]
---
`systemd` 裡，除了用來操作服務的 `systemctl` 指令，另外還有一個 `journalctl` 指令，能夠用各種方式查看服務執行的日誌。也就是說，這對於除錯也是很有幫助的。
<!--more-->

---
## `journalctl` 指令

Journalctl 指令的結構如下：
```
$ journalctl <條件篩選>
```

### 所有日誌
```javascript
// 顯示所有日誌（從最早的紀錄開始）
$ journalctl

// 反轉日誌的輸出順序（從最新的紀錄開始）
$ journalctl -r
// 或
$ journalctl --reverse

// 根據時間顯示日誌
$ journalctl -S -U
// 或
$ journalctl --since= --until=
```

### 追蹤日誌
```javascript
// 顯示最新的日誌，並不斷顯示新產生的日誌
$ journalctl -f
// 或
$ journalctl --follow
```

### 控制日誌格式

* `short`：預設值，每條日誌佔一行
* `verbose`：以結構化的格式顯示日誌
* `json`：將日誌 json 化，每條日誌佔一行
* `json-pretty`：將日誌 json 化，以人方便閱讀的方式排列
* `cat`：顯示日誌內容，不包含任何數據

```javascript
// 控制日誌顯示的格式
$ journalctl -o <格式選項>
// 或
$ journalctl --output=<格式選項>
```

### 以重要性顯示日誌

* `0`：emerg
* `1`：alert
* `2`：crit
* `3`：err
* `4`：warning
* `5`：notice
* `6`：info
* `7`：debug

```javascript
// 根據重要性等級顯示日誌
$ journalctl -p
// 或
$ journalctl --priority=<等級範圍>
```

### 分頁功能
```javascript
// 在分頁中跳到日誌的底部
$ journalctl -e
// 或
$ journalctl --pager-end

// 不要分頁顯示日誌
$ journalctl --no-pager
```


---
參考資料：
* [Ubuntu Manpage: journalctl](http://manpages.ubuntu.com/manpages/bionic/zh_TW/man1/journalctl.1.html)