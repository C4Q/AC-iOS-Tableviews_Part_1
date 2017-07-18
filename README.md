# AC3.2-Tableviews:  Intro to Tableviews

---
### Readings

1. [Swith TableView Basics - Tutsplus](https://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-table-view-basics--cms-25160)
1.  ["A Closer Look at Table View Cells" - Apple](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7)
2. [Protocols - Swift Library Reference](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
3. [Storyboards Tutorial Part 1 - RW](https://www.raywenderlich.com/113388/storyboards-tutorial-in-ios-9-part-1)

### References

1.  [`UINavigationController` - Apple Docs](https://developer.apple.com/reference/uikit/uinavigationcontroller)
3.  [`UITableViewController`  - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewcontroller)
4.  [`UITableViewDataSource`  - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdatasource)
5.  [`UITableViewDelegate` - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdelegate)
6.  [`UITableView` - Apple Docs](https://developer.apple.com/reference/uikit/uitableview)

### Vocabulary

1. **MVP (Minimal Viable Product)**:  is a product with just enough features to satisfy early customers, and to provide feedback for future development. [MVP - Wiki](https://en.wikipedia.org/wiki/Minimum_viable_product)
2. **`cellForRow`**: shorthand for the `UITableViewDataSource` method `tableView(_:cellForRowAt:)`. Used to describe the cell at a specific `row`/`section` in a `UITableView` - [Docs](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614861-tableview#)
3. **`reuseIdentifier`**: String value that you use to specify a "prototype" cell in a table. [Docs](https://developer.apple.com/documentation/uikit/uitableviewcell/1623246-reuseidentifier#)
4. **Protocol**: A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
5. **Adoption/Conforming**: The process of saying a class, structure, or enumeration will fulfill the blueprint of a protocol. Any type that satisfies the requirements of a protocol is said to conform to that protocol. [Docs](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
    - *UITableViewController **adopts** the UITableViewDataSource protocol*
    - *UITableViewController **conforms** to the UITableViewDataSource protocol*
    - These are mostly just synonyms of each other.
6. **Unit Tests**: In computer programming, unit testing is a software testing method by which individual units of source code... are tested to determine whether they are fit for use ([Wiki](https://en.wikipedia.org/wiki/Unit_testing))


---
### 0. Objectives
1. Become familiar with adding various UI elements to a storyboard (`UINavigationController`, `UITableViewController`)
2. Understand how [`UITableView`s](https://developer.apple.com/reference/uikit/uitableview) efficiently display and manage data in `UITableViewCell`s (["A Closer Look at Table View Cells"](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7))
3. Learn how to populate and display data in `UITableView` by way of its delegate protocols (`UITableViewDataSource`,  `UITableViewDelegate`)
4. Further your understanding of protocols ([Swift 3 - Protocols](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html))
5. Understand the reasoning behind testing and practice using tests

---
### 1. C4Q Movie Reel

#### Whip it, *Reel Good*!

Turns out, Access Code has partnered with a local media company that specializes in movie databases named *Reel Good Media*. *Reel Good* is a scrappy young startup that's looking to add to its mobile presence with a clean, functional app that can display info they store in their database. In this partnership, Access Code will help Reel Good develop their app to their specifications.

In this first draft of the app, Reel Good wants a simple prototype that they can test and give feedback on. According to Reel Good, their ideal MVP ([minimum viable product](https://en.wikipedia.org/wiki/Minimum_viable_product)) would have:

1. A `UINavigationBar` at the top
2. A `UITableView` to list data from a subset of their database info
3. `UITableViewCell`s large enough to be able to list the `title`, `year` and `synopsis` of their movies

Your team of developers have also figured out that in order to be able to populate data from Reel Good's database, you will need a way to parse their database data into:

1. A `Movie` object
2. A `Actor` object

---

### 2. Instructions

#### Storyboard Setup

Open the project labeled `Tableviews_Part_1.xcodproj` and get familiar with the structure of the project
> You'll notice that the project is divided into a few folders, and that your `Movie` and `Actor` Swift files are made for you, but are currently empty. The storyboard should also be blank.
> If you tried to run the project now, you'd see a splash screen with the app's logo followed by a blank screen in your simulator

![Project organization - Models](./Images/model_structure_xcode.png)

Click on `Main.storyboard` to open the file in your main window. Now add a `UITableviewController` by dragging it over into the editor window from the *Object Library* in the *Utilies Area*. You can save yourself some time by using the search filter to search for "table".

![Locating UIElements in Xcode](./Images/selecting_UI_element_no_filter.png)
![Filtering UIElements in Xcode](./Images/selecting_UI_element_with_filter.png)

With the `UITableViewController` selected in the storyboard, we're going to *embed* a `UINavigationController`  by going to `Editor > Embed In > Navigation Controller`. Go ahead and try running the project now.

<details><summary>Q: Why is the screen still blank?</summary>
<br>
Generally, the storyboard will reflect the UI our app should have. But we need to tell Xcode where our app actually begins! We do this by setting the <b>Is Initial View Controller</b> flag on the <code>UINavigationController</code>. We can set this property by selecting the  <code>UINavigationController</code> in storyboard, and then going into the <b>Attributes Inspector</b> in the right pane in Xcode
<br>
<img src="./Images/is_initial_screenshot.png" width="200">
<br><br>
</details>
<br>

Out of the box, the `UITableViewController` you added is of type `UITableViewController` (makes sense, right? 😆). But to customize it to suit our needs, we'll need to subclass `UITableViewController` and then update storyboard to let it know that the `tableViewController` we've added is really our subclass's type.

- Create a new file (File > New File > Cocoa Touch Class)
    - Name the new file `MovieTableViewController`
    - Change it to be a subclass of `UITableviewController`
    - Finally, save it into a new folder called `View Controllers`
- Back in storyboard, select the the `UITableViewController`.
    - Next, take a look at the *Identity Inspector* in the *Utilities Area*
    - Change this from `UITableViewController` to `MovieTableViewController`. If all is working, Xcode should autocomplete this class name for you

![Changing subclass in storyboard](./Images/selecting_correct_subclass.png)

To make sure we've got everything hooked up right, add the following code to `viewDidLoad()` in `MovieTableViewController`:

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reel Good!"
        self.tableView.backgroundColor =  UIColor.blue
}
```
Now rerun the project. You should now see a blue screen along with a navigation bar that says "Reel Good!". If you see the image displayed below, then well done!

![Blue Screen of Good (BSOG)](.Images/blue_screen_real_good.png)

> **Developer Tip:** Why did we make the background blue? In order to visualize changes easily, developers will make views bright, very identifiable colors. In order to make sure that our storyboard matched our code, we added a very obvious visual marker so that we could (quickly) determine our changes have gone into effect. Swift has a lot of color constants that you can use, like `UIColor.red`, `UIColor.yellow`, `UIColor.green`, etc.


### 3. Intro To Testing 👨‍💻

When you have very large development teams and large code bases, it's tough to make changes without some unintended side effect. What you might consider a small change to the code in a single file, can sometimes have far reaching consequence in some other very different part of an app. So, how can we ensure that changes we make don't break something elsewhere?

**Testing.**

Testing is simply writing code to make sure that other code works as intended. There are some very strong and developed opinions on how to test and reasons why testing should be done. Developers can be very split on the subject, but it certainly is wise to know what's possible with testing and why it adds value.

In testing, you take a known *input* and *assert* a particular *output* should happen. For example, in parsing Reel Good's data from their database we want to make sure that the data is formatted correctly for our app. It's possible that their database changes how it stores its data and it has an effect in our app because we can no longer r"ead" it correctly. Testing is also very useful in another way: you know what the answer *should* be, so when something does break you already know the correct answer to the issue -- you just need to figure out how to get the code to make that correct answer happen. This process of *reverse engineering* can be very helpful in debugging and understanding code in general.

Testing in Swift is done via the `XCTest` framework, and this project has a simple example of how testing works (`Tableviews_Part_1Tests.swift`). There are a few points that are important to remember:

- Testing is run separately from Building and Running (meaning, your project can Build & Run but still not pass its tests)
- Testing is started with `Product > Test` or with `Cmd+U`
- All functions in a test begin with the word "test" followed by a description of what the function will be testing
- It is important that test functions describe very well what they test, and that the failure messages will help you debug the problem
- But take care! A test can be written incorrectly, just like any other piece of code.
- Otherwise, a test class and its functions are like any other class/function in Swift!

---

### 4. Models and Tests

Fortunately for us, another member of our developer team working on the Reel Good project wrote out some tests on our models, `Movie` and `Actor`. Unfortunately... they didn't stage their changes in git for the actual parsing code for the model class. Not only that, they didn't save their local changes either!

What this means, is that we're going to have to reverse engineer a solution to parsing our data based on the tests that they had written. How do we even begin this process though?

#### Reverse Engineering



---

### 5. Populating Cells
Let's get rid of that blue background, shall we?

Ok, now that we have our database being properly parsed into objects we can use, let's display them in the tableview.

To understand how a tableview populates its cells, and what the table and cells look like (cell height, number of cells, header views, etc.), we need to look at two protocols that a `UITableViewController` conforms to:

1. `UITableViewDataSource` - *"The data source provides the table-view object with the information it needs to construct and modify a table view" - Apple Doc*
2. `UITableViewDelegate` - *"Optional methods of the protocol allow the delegate to manage selections, configure section headings and footers, help to delete and reorder cells, and perform other actions." - Apple Doc*

The methods of the `UITableViewDelegate` protocol are optional, but there are three required methods for `UITableViewDataSource`

1. "numberOfSections": `numberOfSections(in tableView: UITableView) -> Int`
2. "numberOfRows": `tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int`
3. "cellForRow": `tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell`


#### numberOfSections:
Not too much to say here. Creating different sections can be useful if you have different types of cells or different sets of data to display. In our case, we're just going to set this to 1 for our small data set and one kind of cell

#### numberOfRows:
We don't know exactly how many rows of data we'll have. All we know is that each row will contain the data for a single Movie object. But really, this is where a tableview shines since it allows for an unknown amount of data to be displayed. In this case, we'd like to present as many Movies as we have in movieData array

Here's a important thing to remember though, in the lifecycle of a tableview it is possible that the tableview will run the `numberOfRows` function before we have time to load data in our Movie array. In fact, we can't just leave it as `self.movie?.count` as it expects a non-optional `Int` value. But this is a perfect time to use the **nil coalescing** operator.

All this operator says is that if the value of to the left of the `??` is nil, to use the value to the right of the operator instead. Functionally, it's equivalent to the ternary operator `?:`

    let numberOfMovies: Int = self.movieData?.count != nil ? self.movieData!.count : 0
    let numberOfMovies: Int = self.movieData?.count ?? 0 // same as the above

This is a nice shorthand for simple `nil` checking instead of having to use an `if-let` or `guard` statement

#### cellForRow:

For every type of cell you create, you'll need to define it's `cellIdentifier` property. The `cellIdentifier` will let `cellForRow` know which kind of cell it will `dequeue` for use.

Think of how many movies have been made since cinema began.. likely in the tens of thousands. If Reel Good wants us to display (potentially) all of these movies in this table, that's going to be a lot of `Movie` instances. And each of those instances is going to need its own cell, which itself is a couple of `UIView`s. The amount of memory needed to store and display all of that data is beyond what an iPhone could handle all at once. So instead, a tableview efficiently manages its cells by only creating as many as it needs to show on the screen at once. So if only 10 cells can be visible at a time on the screen, then only 10 cell exist in memory.

When you scroll up or down, behind the scenes, the table view takes the cell that just scrolled off screen and reuses it! That cell get the data of the next `Movie` object and gets placed at the bottom of the table. In that way, the views are rotated from top to bottom (or vice-versa) as needed.


#### Cell Styles

There are a few built-in styles available to us, and we're going to use `subtitle` for this project. Thanks to the documentation, we know we have two text field for use: `textLabel` and `detailTextLabel`.

How do we get the movie data from our array into each cell, in the proper order?
Because we can use subscripts to access members of an array, we use the `indexPath` passed into this function to find the right element to display.

An `indexPath` has a `section` property and a `row` property. We know that there will only be 1 section total (because we set it to one in `numberOfSections:`) and that each row will correspond to a single movie object (thanks to `numberOfRowsInSection:`). So by looking at the `row` value of the `indexPath`, we can use that as the subscript value in the movies array.

---

#### 5. Resizing Cells
Excellent! Reel Good absolutely adores our prototype. They only wished that they could see the movie poster art in their cells, and that the cells could expand to accomodate the text from the movie summary. Unfortunately, we tell them:

> [When working with table view cells, you cannot change the layout of the predefined content (for example, the textLabel, detailTextLabel, and imageView properties).](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithSelf-SizingTableViewCells.html)

But, this was just a prototype and now there's more to come in version 2!
