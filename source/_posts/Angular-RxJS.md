---
title: Angular 學習筆記 - RxJS
date: 2022-05-03 13:06:15
tags: [Angular, JavaScript, RxJS]
---

因為專案使用 `Angular` 開發，而 `Angular` 提供 `RxJS Library` 來做非同步請求的管理，身為一個前端工程師，為了讓程式碼更精簡好讀（~~也為了看起來更厲害~~），認真了解 `RxJS` 絕對是必要的。

<!--more-->

---
## 什麼是 ReactiveX？

ReactiveX 在官網（[https://reactivex.io](https://reactivex.io）的首頁開宗明義寫道：
> An API for asynchronous programming with observable streams.

由此可知 `ReactiveX` 的出發點是「對可觀察的串流做非同步處理」，而`RxJS` 是可用 `JavaScript` 操作的 Library。

另外，ReactiveX 對自己的定義則是：
> ReactiveX is a combination of the best ideas from
the Observer pattern, the Iterator pattern, and functional programming.

也就是說，這是一個集結了下列三種設計模式精華的好開發方式：
* Observer Pattern
* Iterator Pattern
* Functional Programming

了解 `RxJS` 後，再回來看這串定義，就比較能夠體會了。


---
## 如何使用 Angular RxJS Library？

在 `Angular` 中要使用 `RxJS` 處理資料流，可以使用一個叫做 `pipe` 的 API 來將處理方式包起來：
```javascript=
import { Observable, of } from 'rxjs';
import { ajax } from 'rxjs/ajax';
import { map, catchError, tap, take } from 'rxjs/operators';

const apiData = ajax('/api/data').pipe(
    take(1),
    map((res: any) => {
        // 使用 map 對資料流中每一個資料做一些操作
        if ( !res.response ) {
            throw new Error('Value expected!');
        }
        return res.response;
    }),
    catchError(err => {
        // 當發現錯誤時，用 of 建立一個新的 Observable 並回傳
        console.log(err);
        return of([]);
    }),
    tap((data: any) => {
        // 透過 tap 對資料做一些操作
        console.log(data);
    })
);

// 訂閱 Observable 物件來執行觀察
apiData.subscribe();
```

### API & Operators

整理我自己常用的 API 與 operators：

* `pipe`：將多個 operators 包裝起來
* `tap`：將資料取出來做處理，沒有其他衍伸效果
* `takeUntil`：訂閱此 Observable，直到觸及設定的條件
* `of`：建立一個新的 Observable
* `catchError`：捕捉錯誤
* `debounceTime`：為了不過度頻繁地發出非同步請求，設定一個延遲時間
* `take`：只取 N 筆資料
* `map`：遍歷串流中的每一筆資料
* `filter`：根據條件篩選出要的資料
* `switchMap`：在串流中發出另一筆非同步請求，並回傳一個 Observable


---
## 總結

目前我自己在 Angular 專案中所使用的 `RxJS`，全部都是用來處理 AJAX 請求的，在程式碼撰寫風格上逐漸建立起一定的習慣，也增加了易讀性與可擴充性。

以上就是目前對 `RxJS` 粗淺的了解。


---
參考資料：
* [TechBridge 技術共筆部落格 - 希望是最淺顯易懂的 RxJS 教學](https://blog.techbridge.cc/2017/12/08/rxjs/)
* [Will 保哥 - RxJS6 新手入門](https://www.youtube.com/watch?v=BA1vSZwzkK8)
* [iT邦幫忙 - 30 天精通 RxJS](https://ithelp.ithome.com.tw/users/20103367/ironman/1199)
* [Angular RxJS 函式庫](https://angular.tw/guide/rx-library)
