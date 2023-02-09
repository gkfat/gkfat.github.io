---
title: TypeScript 學習筆記 - 初探
date: 2023-02-09 12:38:12
tags: [TypeScript]
---

因為專案使用 `Angular` 的關係，我在開發上逐漸習慣都使用 `TypeScript`，甚至連近期在練習使用 `Node.js` 寫後端專案，也會盡可能使用 `TypeScript`。用習慣了之後，再回去看原生的 `JavaScript`，總是會感到渾身不對勁。

<!--more-->

線上測試 `TypeScript`：https://www.typescriptlang.org/play

---
## 什麼是 TypeScript？

> 一言以蔽之，就是「基於 JavaScript，但能夠定義型別」的程式語言。

當一段程式碼在 `JavaScript` 長這樣：
```javascript=
let whatIsThis;
// 經過一串程式碼，塞入了不曉得什麼鬼東西...
console.log(whatIsThis);
// 可能是任何東西...
```

在 `TyepScript` 中就會長這樣：
```typescript=
let whatIsThis: string[];
// 經過一串程式碼，塞入了不曉得什麼鬼東西...
console.log(whatIsThis);
// 你知道他一定是個字串陣列
```

`TypeScript` 的好處就是能夠「清楚地定義型別」，大幅提升程式碼在閱讀與維護上的容易程度。

剛開始使用 `TypeScript` 的時候，可能會覺得很麻煩，需要多寫一堆程式碼來定義明擺著的事實，但當專案變大、程式碼變長了之後，你會逐漸發覺很多錯誤都能提早避免，而不是等到要 run code 的時候才報錯。

---
## Enum & Interface & Class

不僅在維護上，使用 `TypeScript` 也能讓開發更有效率。舉例來說：
```typescript=
// 定義一個 Book 介面
interface Book {
    author: string;
    pages: number;
}

// 定義一個 Library 類別
class Library {
    private books: Book[] = [];
    constructor(books: Book[]) {
        this.books = books;
    }

    // 取得所有的 Book
    public getBooks(): Book[] {
        return this.books;
    }

    // 增加新的 Book
    public addBook(newBook: Book): Book[] {
        this.books.push(newBook);
        return this.books;
    }
}

// 定義 books 的型別為 Book[]，在建立內容時 TypeScript 就會檢查是否符合 Book 屬性
const books: Book[] = [
    {author: 'John', pages: 20},
    {author: 'Jane', pages: 50},
    {author: 'Peter', pages: 100},
    {name: 'Hello', pages: 10} // 會因為 Book 介面沒有 name 屬性而報錯，在開發期間就知道這裡會有錯誤
]
let library = new Library(books);
library.getBooks();
```

或者可以更方便地使用繼承／擴充，讓程式碼更結構化：
```typescript=
// 使用 enum 直接依順序列舉
enum LegsEnum {
    noLeg,   // 0
    twoLegs, // 1
    fourLegs // 2
}

interface Animal {
    legsType: number;
    canFly: boolean;
    sound(): string; // Animal 天生就可以叫
}

class Snake implements Animal {
    legsType = LegsEnum.noLeg; // 可以直接指派 enum 的值，legsType === 0
    canFly = false;
    sound(): string {
        return 'sss';
    }
}

class Dog implements Animal {
    legsType = LegsEnum.twoLegs;
    canFly = false;
    sound(): string {
        return 'bark bark';
    }
}

class Bird implements Animal {
    legsType = LegsEnum.twoLegs;
    canFly = true;
    sound(): string {
        return 'jo jo';
    }
}
```

如此一來，看著程式碼就可以很迅速地理解各種類別帶有的屬性及方法，光是這點就足以預防很多笨笨的錯誤了。

在開發時，`TypeScript` 也會幫你列出正在使用的類別所帶有的屬性及方法，例如：
```typescript=
let bird1 = new Bird();
bird1. // 當程式碼寫到這裡時，會列出以下東西
// bird1.legsType
// bird1.canFly
// bird1.sound
```

實在是相當便利。

另外一個好處是，當程式碼需要改動時，`TypeScript` 會自動檢查出還有哪些地方是需要修正的，不會在程式碼上線時才 crash。

`TypeScript` 真的是個好東西，尤其對於想把程式碼定義清楚的人而言，尤其推薦！

---
參考資料：
* [What are the differences between TypeScript and JavaScript?](https://www.sanity.io/typescript-guide/typescript-vs-javascript)
* [An Introduction to TypeScript Interfaces](https://betterprogramming.pub/introduction-to-typescript-interfaces-extending-interfaces-and-classes-af10fcfc1238)