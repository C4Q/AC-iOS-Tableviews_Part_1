# C4Q Movie Reel 
### (AC3.2-Tableviews_Part_1: **Intro to Tableviews**)
---

### Whip it, *Reel Good*!
Turns out, Access Code has partnered with a local media company that specializes in movie databases named *Reel Good Media*. *Reel Good* is a scrappy young startup that's looking to add to its mobile presence with a clean, functional app that can display info they store in their database. In this partnership, Access Code will help Reel Good develop their app to their specifications. 

In this first draft of the app, Reel Good wants a simple prototype that they can test and give feedback on. According to Reel Good, their ideal MVP ([minimum viable product](https://en.wikipedia.org/wiki/Minimum_viable_product)) would have: 

1. A `UINavigationBar` at the top
2. A `UITableView` to list data from a subset of their database info 
3. `UITableViewCell`s large enough to be able to list the `title`, `year` and `synopsis` of their movies

Your team of developers have also figured out that in order to be able to populate data from Reel Good's database, you will need a way to parse their database data into:

1. A `Movie` object
2. A `Actor` object

---

### Goals
1. Become familiar with adding various UI elements to a storyboard 
  2. `UINavigationController` ([Apple Docs](https://developer.apple.com/reference/uikit/uinavigationcontroller))
  3. `UITableViewController` ([Apple Docs](https://developer.apple.com/reference/uikit/uitableviewcontroller))
2. Understand how `UITableView`s efficiently display and manage data in `UITableViewCell`s (["A Closer Look at Table View Cells"](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7))
3. Learn how to populate and display data in `UITableView` by way of its delegate protocols
  4. `UITableViewDataSource` ([Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdatasource))
  5. `UITableViewDelegate` ([Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdelegate))
4. Further your understanding of protocols ([Swift 3 - Protocols](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html))

---

### Instructions

1. Open the project labeled 
