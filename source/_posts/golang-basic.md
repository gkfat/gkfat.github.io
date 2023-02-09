---
title: Golang 學習筆記 - 初步接觸 Go!
date: 2021-09-05 08:34:03
tags: [後端開發, Go]
---

為了看懂後端主管寫的專案原始碼，趁著最近專案開發中間空檔，趕快來學習一下 Golang！基於自學習慣，我會先概覽這個語言的基礎，之後再針對遇到的主題進一步研究。

<!--more-->

本次整理出三個部分：
* [Go 的資料型別](##Go的資料型別)
* [Go 的套件](##Go的套件)
* [Go 的撰寫風格](##Go的撰寫風格)

---
## Go的資料型別
#### 數字（Number）
* 無號整數：`uint`、`uint8`、`uint16`、`uint32`、`uint64`
* 有號整數：`int`、`int8`、`int16`、`int32`、`int64`
* 浮點數：`float32`、`float64`
* 複數：`complex64`、`complex128`
#### 字串（String）
* `string`：UTF-8 編碼的字串
* `byte`：不以編碼處理的字串
* `rune`：型別為`int32` 的值
#### 布林（Boolean）
* `true`：真
* `false`：偽
#### 陣列（Array）
* 以數字為索引的線性容器，長度固定。
#### 結構（Struct）
* 宣告一個資料結構（非實體），具有哪些參數以及型別。
#### 指標（Pointer）
* 指向儲存其他值的「位址」，透過指標可間接存取值。
#### 切片（Slice）
* 以數字為索引的線性容器，長度可以伸縮。
#### 映射（Map）
* 以 key-value pair 的非線性資料結構，以雜湊方式儲存在記憶體中。
#### 函式（Function）
* 提供具有行為的函式，作為型別來定義變數。
#### 通道（Channel）
* 在 Goroutine 之間傳遞資料。
#### 介面（Interface）
* 抽象型別，不顯露內部的值，而只提供可操作的行為。


---
## Go的套件
Go 以 package 來組織程式，因此每個原始碼檔案的開頭都會是 `package <fileName>`，以作為一個 package 來讓其他檔案調用。

下面整理 Go 內建的一些常用套件。

### `fmt`：格式化輸出以及掃描輸入
#### 轉換格式：`fmt.Print()`、`fmt.Printf()`、`fmt.Println()`
轉換格式後輸出值，如下例：
```go=
appleColor := "red"
fmt.Printf("Color of apple: %v\n", appleColor)
// 印出 Color of apple: red

fmt.Printf("Color of apple: %q\n", appleColor)
// 印出 Color of apple: "red"

fmt.Printf("Color of apple: %T\n", appleColor)
// 印出 Color of apple: string
```

||常用轉換格式|
|-|-|
|%v|值自然格式|
|%s|字串|
|%q|加引號的字串|
|%T|值型別|

#### 組合字串：`fmt.Sprint()`、`fmt.Sprintln()`、`fmt.Sprintf()`
不會印出東西，而是拿來組合字串用的。
```go=
v1 := "I"
v2 := "am"
v3 := "Iron Man"

combineString := fmt.Sprintln(v1, v2, v3)
fmt.Println(combineString)
// 印出 I am Iron Man
```

### `os`、`io`、`bufio`：存取作業系統
#### 存取作業系統：`os.Open()`、`os.Create()`、`os.Remove()`、`os.Mkdir()`
建立、編輯或移除作業系統中的資料夾、檔案。
#### 存取命令列參數：`os.Args[1:]`
取得開啟檔案時命令列的參數，`[1:]` 為刪除掉第一個參數（程式執行的路徑）。
#### 存取作業系統：`io/ioutil.ReadFile()`、`io/ioutil.ReadDir()`
建立、編輯或移除作業系統中的資料夾、檔案。
#### 存取作業系統：`bufio.NewWriter()`
實作了 `io` 的一些介面，能更方便地建立、編輯或移除作業系統中的資料夾、檔案。
。

> 如果你跟我一樣，覺得這些 Package 都很像，產生了「這麼多種，到底什麼時候要用哪個？差別在哪裡？」的疑惑，可以看看這篇：[掘金 - Go指南10-谈谈对Golang IO读写的困惑](https://juejin.cn/post/6864886461746855949)
> 
### `flag`：從命令列取得參數在程式碼中使用
#### 設置外來變數：`flag.String()`、`flag.Bool()`、`flag.Int()`、`flag.Var()`
使用這個套件，可以讓使用者在啟動專案時代入參數，進而達到一份專案中包含多功能的效果。

---
## Go的撰寫風格
### 使用指標（Pointer）來做變數處理

在宣告一個變數時，會在記憶體中給予其一個位址來存放它的相關設定（型別、值），而 Go 提供一種方法來取用該變數的位址或者指向它做變更，這樣就不用拷貝該變數，多消耗一個記憶體位址。當需要跨函式對同一變數做存取時，這個方法相當有幫助。

* `*`：Point to，指向某個記憶體位址的值
* `&`：Address of，某個變數的記憶體位址

```go=
a := 7   // 宣告一個 int 變數
p := &a  // 宣告一個變數 p，指向 a 的位址

fmt.Printf("Value of a:%v\n", a)
// 印出 Value of a:7

fmt.Printf("Address of a:%v\n", &a)
// 印出 Address of a:0xc000118000

fmt.Printf("Value of p:%v\n", p)
// 印出 Value of p:0xc000118000

*p = 8   // 修改 *p 的值，影響到 a
fmt.Printf("Value of a:%v\n", a)
// 印出 Value of a:8
```

從上述例子可以看出，`p` 這個變數儲存的是 `a` 的記憶體位址，而修改 `*p` 的值，等於修改到 `a` 的值。若將 `p`（a.k.a:`a` 的記憶體位址）作為變數在函式之間傳遞使用，再用指標指向 `*p`，就可以在各函式之間對同一個變數做處理，不用一直耗費記憶體來建立新的變數。


### 利用 `defer`（延遲觸發）來做例外處理
對於例外處理的這一塊，因為還沒有實際寫出一個 Go 專案，因此還不是很能領會實作方式。

#### `defer`（延遲處理）
* 使用 `defer` 將工作延遲到想要的時間點執行。
* 當程式結束時，多個 `defer` 處理將以反向順序執行，也就是 LIFO（Last In First Out）。
#### `panic`（中斷）
* 當發生錯誤（也就是常見的 `err != nil`）時，透過 `panic` 來將函式中斷。
#### `recover`（恢復）
* 在發生了 `panic` 而導致流程中斷後，如果想要讓程式繼續做別的處理，就可以使用 `recover`。但 `recover` 必須在 `defer` 中執行，否則回傳值會是 `nil`。


---
### 利用 `goroutine` 來做併發處理
Go 特色之一就是對於 concurrency 的處理，而 Go 提供的作法就是使用 goroutine。

#### `Goroutine`（執行緒）
只要在函式前加上 `go`，就會開啟一個新的 goroutine。
```go=
f()    // 呼叫執行 f()
go f() // 建立一個新的 goroutine 來呼叫執行 f()
```
Goroutine 能讓各個函式同時進行，而不用相互等待，我以前端的 `Ajax`，或 Python 的 `Thread` 來理解，就比較能想像了。

#### `Channel`（通道）+ `Select`（選擇）
Channel 是運行中的 goroutine 之間的連線管道，可以讓其中一個 goroutine 發送訊息給其他 goroutine。要建構 channel，可以這樣做：
```go=
ch := make(chan int)     // 建構一個型別為 chan int 的 channel
ch2 := make(chan string) // 建構一個型別為 chan string 的 channel
ch3 := make(chan bool)   // 建構一個型別為 chan bool 的 channel
```
Channel 具有 **發送** 與 **接收** 兩種基本操作，通稱為 **通訊**。
```go=
ch <- x   // 發送 x 給 channel
y  <- ch  // y 接收來自 ch 的值
<- ch     // 拋棄結果
close(ch) // 關閉 channel
```
可以透過 **關閉** 操作來讓 channel 不再接收值，若再發送值到此 channel，會引發 panic。在已經關閉的 channel 上取值，會取出直到沒有值為止，之後的接收操作會得到 nil。

對 channel 的進一步討論，我會另外再整理一篇心得。

#### `Mutex`（互斥鎖）
當有多個 gouroutine 在運行中時，有時會出現互相影響的狀況，此時需要設定讓其中一個 goroutine 先執行完畢，才能開放給其他 goroutine 使用，而這樣的方式就是 `Mutex.Lock()`。《精通 Go 程式設計》中舉了以下例子：
```go=
import "sync"

var (
    mu sync.Mutex
    balance int
)

func Deposit(amount int) {
    mu.Lock()                   // 上鎖
    balance = balance + amount  // 確保一次只有一個 goroutine 能改變餘額
    mu.Unlock()                 // 釋放鎖
}

func Balance() int {
    mu.Lock()
    b := balance
    mu.Unlock()
    return b
}
```

#### `WaitGroup`（等待群組）
若今天要等到所有 goroutine 都處理完畢再進行下一個動作，除了 channel 之外，`sync` 套件也提供了 WaitGroup 的方式來達到這樣的效果（以 UML 來說，就是「等待分支節點結合 Join」）。

詳細的 WaitGroup 使用方式就不贅述。

#### `Context`（背景）
叫做背景可能不太精確，context 是在剛開始用 `gin` 寫 http server 的時候就很常見的一個東西，但實際上還是不太了解它的意思。經過粗淺的研究後，才知道 context 的主要用途，是在背景管理所有不定數量的 goroutine。

對於目前的我來說，理解 context 還太早，等之後對 goroutine 的使用更熟悉了，再回頭來重新認識 context，會是比較有效率的學習方式。


---
## 小結
經過本文的整理，對 Go 有了基本淺層的認識，也大致上知道 Go 的優勢以及風格是什麼，這樣應該會對理解主管的專案程式碼有些許的幫助（吧）。愈學愈覺得，Go 是個很棒的語言，主要是他的規範很嚴格，但又相當好懂，對於整理與維護來說非常友善！雖然目前的自己都在寫義大利麵 code，但心中也是有著寫 clean code 的嚮往啊！

總而言之，大家一起學 Go 吧！


---
參考資料：
* Alan A.A. Donovan - 精通 Go 程式設計
* [PJCHENder - [Golang] Struct](https://pjchender.dev/golang/structs/)
* [iT邦幫忙 - Golang 入門到進階實戰：Day 18 常用基本庫介紹](https://ithelp.ithome.com.tw/articles/10223934/)
* [掘金 - Go指南10-谈谈对Golang IO读写的困惑](https://juejin.cn/post/6864886461746855949)
* [小惡魔 - AppleBOY - 在 Go 語言內管理 Concurrency 的三種方式](https://blog.wu-boy.com/2020/08/three-ways-to-manage-concurrency-in-go/)
* [iT邦幫忙 - Go劍復國-30天導入Golang：Golang Concurrency Pattern](https://ithelp.ithome.com.tw/articles/10208936)