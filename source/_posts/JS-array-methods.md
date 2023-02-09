---
title: JavaScript 學習筆記 - 陣列操作方法
date: 2019-09-14 15:08:04
tags: [JavaScript]
---

在寫 JavaScript 時，很常會需要去操作陣列，為了加深自己對陣列操作方法的印象而整理了這一篇筆記。
<!--more-->

---

## 操作陣列的目的

為了更好地分類內容，我們會把性質相近的元素放在同一個陣列，然而時常又需要對這個陣列做查找、提取、新增、刪除、或其他操作。JavaScript 內建有非常多操作陣列的方法（Methods），不過常用的也只有幾種而已。

陣列具有兩個重要的屬性： `length` 與 `index`，透過這兩個屬性，我們得以直接接觸到目標內容，就不需要迭代整個陣列。


## 操作陣列的方法

|方法|描述|
|-|-|
|forEach()|對每一個元素執行傳入的 `callback`|
|map()|return 一個新陣列，每一個元素為執行傳入的 `callback` 後的結果|
|filter()|return 一個在 `callback` 中返回 true 的元素的新陣列|
|every()|如果陣列每一項元素都在 `callback` 中返回 true，則返回 true|
|some()|如果陣列至少有一項元素在 `callback` 中返回 true，則返回 true|
|reduce()|透過 `callback` 對陣列中每個元素做運算，並 return 一個單一的值|
|concat()|合併兩個陣列，並 return 新陣列|
|copyWithin()|複製陣列中某些元素，並取代陣列中指定 `index` 的元素|
|fill()|將陣列中的元素，替換為傳入的值|
|keys()|return 一個新陣列，每一個元素是原陣列中每個元素的 `index` 值|
|find()|將陣列中每一個元素帶入 `callback` 判斷，並回傳第一個符合條件的元素|
|findIndex()|將陣列中每一個元素帶入 `callback` 判斷，並回傳第一個符合條件的元素的 `index`|
|indexOf()|在陣列中由前往後查找目標元素的 `index`|
|lastIndexOf()|在陣列中由後往前查找目標元素的 `index`|
|join()|將陣列內容合併成一個字串|
|toString()|return 一個字串，內容是以逗號分隔的陣列元素|
|shift()|移除並返回陣列的第一個元素|
|pop()|移除並返回陣列的最後一個元素|
|unshift()|在陣列的開頭新增傳入的元素|
|push()|在陣列的最後新增傳入的元素|
|reverse()|反轉陣列元素的排列順序|
|sort()|排序陣列的元素|
|slice()|return 一個新陣列，內容為指定 `index` 及長度的元素|
|splice()|可新增或移除指定 `index` 的元素|
|isArray()|判斷一個物件是否為陣列，return true / false|
|from()|將物件依照 `callback` 轉換為陣列|
|includes()|判斷陣列中是否含有某個元素，return true / false|

---

## 常用的方法

僅管操作陣列的方法有這麼多種，其實平常也不會全部都用到。以下整理了幾個我本身較常使用的方法。

### `forEach()` `map()`
當想要對一個陣列中每個元素做操作，這兩種方法就很好用。 若只是想對每個元素進行操作，就用`forEach()`（有點類似使用 `for` 迴圈，不過寫法更簡潔）；若操作完後要直接回傳一個陣列，就用 `map()`。

### `filter()` `every()` `some()`
在實現篩選功能的時候，這幾個方法就很適合。

若需要較複雜的篩選條件，就用`filter()` 遍歷整個陣列，並直接返回一個新陣列；而 `every()` 與 `some()` 可以拿來做比較簡單的篩選，只需判斷 `true` / `false`。

### `sort()`
需要對陣列做排序的時候使用。若要做大小排序，只需代入下列匿名函式：
```javascript
array.sort(function(a, b) {
  return a - b;
});
```
當然還可以做更複雜的排序。

### `reduce()`
有點類似 `forEach()` 與 `map()` 的用法，但更適合在要對整個陣列運算出一個單一結果時使用。

### `find()` `findIndex()`
能夠用抽象的描述找到符合條件元素的 `index`。通常接著會搭配使用其他的方法，像是取出該元素或複製、刪除等等。

### `indexOf()` `lastIndexOf()`
如果已經知道目標元素的長相，這兩個方法能夠直接查詢 `index`，方便你做接下來的操作。

### `splice()`
能夠很方便地在陣列中指定位置刪除／新增元素，有三個參數可以代入：
```javascript
array.splice(index, howmany, items)
```
|參數|描述|
|-|-|
|index|必需。為正／負整數，指定在陣列中開始操作的位置。|
|howmany|必需。指定要刪除的數量，若不刪除元素則設置為 0。|
|items|可選。向陣列新增的元素。|

### `push()`
若只是需要將新元素插入到陣列的最後，直接使用 `push()`。

### `slice()`
從陣列中複製一段內容，並回傳一個新陣列。
```javascript
array.slice(start, end)
```
|參數|描述|
|-|-|
|start|為正／負整數，指定在陣列中開始操作的位置。|
|end|可選。提取片段的結尾位置，若有設定則提取到該位置的前一個元素，若不設定就會提取到最後。|

### `reverse()` `join()`
這兩個方法有時候會搭配使用，當你想要把一個字串內的每個字元反轉過來的時候，先使用字串的操作方法 `split()` 將其變成陣列，再做 `reverse()` 反轉每個元素，最後用 `join()` 再讓他變成一個字串。

---
參考資料：
* [Tutorial Republic - JavaScript Array Methods](https://www.tutorialrepublic.com/javascript-reference/javascript-array-object.php)
* [MDN - 陣列的運用](https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Obsolete_Pages/Obsolete_Pages/Obsolete_Pages/%E9%99%A3%E5%88%97%E7%9A%84%E9%81%8B%E7%94%A8)
* [OXXO Studio - JavaScript Array 陣列操作方法大全 ( 含 ES6 )](https://www.oxxostudio.tw/articles/201908/js-array.html)
