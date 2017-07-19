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

![Blue Screen of Good (BSOG)](./Images/blue_screen_real_good.png)

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

The first step, in our case, is to check the tests that have been provided. We'll start with the first test in the list, `func test_Default_Movie_Init()`. (Go ahead and uncomment the code for this function):

```swift
func test_Default_Movie_Init() {
    let testMovie = Movie()

    XCTAssertTrue(testMovie.title == "", "A default init of movie should have an empty sting for title")
    XCTAssertTrue(testMovie.genre == "", "A default init of movie should have an empty sting for genre")
    XCTAssertTrue(testMovie.year == 1970, "A default init of movie should have a year of 1970")
    XCTAssertTrue(testMovie.locations == [], "A default init of movie should have an empty array of strings for locations")
    XCTAssertTrue(testMovie.cast == [], "A default init of movie should have an empty array of strings for actors")
    XCTAssertTrue(testMovie.summary == "", "A default init of movie should have an empty string for summary")
}
```

Run the test and see the output produced (*spoiler:* it will fail). You can run tests by pressing `CMD` + `U` or going into the menu option `Product > Test`.

![Errors in testing](./Images/testing_makes_errors.png)

> Before moving on, take a moment to think about what information about `Movie` we can derive from `test_Default_Movie_Init` ... it's actually quite a lot!

Recall that the general guidelines for a test are that they describe what they are testing and provide feedback to determine what isn't working (so that you can fix it faster). Tests also give you the answer to the question you need to ask, you just need to figure out what the question is -- which is exactly why this is reverse engineering at its core.

So what can we say about our code based on this one testing function? Here are some guiding questions to help you:

1. What object are we trying to test testing?
2. What function of that object is being tested?
3. What should the properties for that object be?

Well, from the name of the function, `test_Default_Movie_Init` we can gather that we're testing out the default initializer of a `Movie` object. Since the initialization takes no parameters, we know that the initilazer will look like:

```swift
class Movie {
    init() {
    }
}
```

From the assertions being made, we know what kinds of properties the object will have (mostly):

```swift
class Movie {
    var title: String
    var year: Int
    var genre: String
    var cast // ??
    var locations // ??
    var summary: String

    init() {
    }
}
```

The only trouble is with `cast` and `locations` since we're given some information that it should be an array (because its default is set to be an empty array), but we're not told the *type* of the elements in that array. Fortunately, the developer that wrote the tests left us a critical clue that we needed in the description of the errors should the assertion fail:

```swift
// thank goodness we got descriptive error messages 🙏
XCTAssertTrue(testMovie.locations == [], "A default init of movie should have an empty array of strings for locations")
XCTAssertTrue(testMovie.cast == [], "A default init of movie should have an empty array of strings for actors")
```

So thanks to the thoughtful developer who wrote the tests, we know we need `[String]`:

```swift
class Movie {
    var title: String
    var year: Int
    var genre: String
    var cast : [String]
    var locations: [String]
    var summary: String

    init() {
    }
}
```

But what about actually filling in the implementation of the init? Well, the tests tell us what each value should be when a new `Movie` is created with this initializer, so:

```swift
class Movie {
    var title: String
    var year: Int
    var genre: String
    var cast : [String]
    var locations: [String]
    var summary: String

    init() {
      self.title = ""
      self.year = 1970
      self.genre = ""
      self.cast = []
      self.locations = []
      self.summary = ""
    }
}
```

The final step is to ensure our tests now run. Go ahead and give it another go!

> If youre feeling adventurous, change some of the assertions so that they produce 'false' instead of 'true'. Re-run the test and observe Xcode for changes.

#### Exercises:

**Adding Another Function to `Movie`**
We've just seen that tests tell us what our expected outputs, given expected inputs, should be. And since we know what we *should* get, we can *assert* that certain things are true. We need to continue filling out the `Movie` class based on the remaining tests. Let's start with one more, `func test_Full_Movie_Init()`

1. Uncomment the code in `func test_Full_Movie_Init()`
2. Think about (or discuss with a partner) what information we can get from the test
3. Write the code the test says is necessary
4. Run the tests and make sure both your tests pass

**Filling in `Actor`**
We now have the task of filling out the `Actor` model class based on the tests provided. Take a look at `test_Default_Actor_Init()` and `test_Full_Actor_Init()` (being sure to uncomment the code in each) and reverse engineer the two functions that `Actor` should have.

> Note: You may be wondering why we created the `Actor` model if the `cast` property of `Movie` is still an array of `String`. Don't worry, we'll be returning to that in another set of exercises.

> TODO
1. Figure out if there are more tests needed
2. At what point are dictionary parsing init should be added? homework
3. Go over cell population
4. Get rid of old branchs
5. add exercises using tests to solve them
6. add tags?

---

### 5. Populating Cells

Now that we have the ability to create `Movie` and `Actor` objects, let's explore how it is we can display them in our tableview. Oh, and let's get rid of that blue background, shall we?

To understand how a tableview populates its cells, and what the table and cells look like (cell height, number of cells, header views, etc.), we need to look at two protocols that a `UITableViewController` *conforms* to:

1. `UITableViewDataSource` - *"The data source provides the table-view object with the information it needs to construct and modify a table view" - Apple Doc*
2. `UITableViewDelegate` - *"Optional methods of the protocol allow the delegate to manage selections, configure section headings and footers, help to delete and reorder cells, and perform other actions." - Apple Doc*

There are three required methods for `UITableViewDataSource` (the methods of the `UITableViewDelegate` protocol are optional) which I list out here in their abbreviated form followed by their function signature:

1. "numberOfSections": `numberOfSections(in tableView: UITableView) -> Int`
2. "numberOfRows": `tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int`
3. "cellForRow": `tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell`

We're obviously going to need some `Movies` to populate our cells, so let's create some in the `viewDidLoad` method of our `MovieTableViewController`. In addition, we're going to want to keep track of the `Movie`s we create by keeping a reference to them as an instance variable, `movieData: [Movie]`:

```swift
class MovieTableViewController: UITableViewController {
    var movieData: [Movie]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reel Good!"
        self.tableView.backgroundColor = UIColor.blue

        self.movieData = [
            Movie(title: "Rogue One", year: 2016, genre: "Sci-Fi", cast: [], locations: ["Space"], summary: "An awesome Star Wars movie"),
            Movie(title: "Wonder Woman", year: 2017, genre: "Superhero", cast: [], locations: ["Europe"], summary: "Wonder Woman fights evil, and wins.")
        ]
    }
```

#### `numberOfSections`:
Not too much to say here. Creating different sections can be useful if you have different types of cells or different sets of data to display. In our case, we're just going to set this to 1 for our small data set and one kind of cell

```swift
override func numberOfSections(in tableView: UITableView) -> Int {
        // We're only going to need 1 section for our limited data, [Movies]
        return 1
}
```

#### `numberOfRows`:
We don't always know exactly how many rows of data we'll have. In this example, we have just two `[Movies]`, but if the overall goal is to create an app to display 1000's of movies, we need a way to account for all of them. All we know for sure is that each row will contain the data for a single `Movie` object. Though in this ambiguity in data set is where a tableview shines -- it allows for an unknown amount of data to be displayed. In this case, we'd like to present as many `Movies` as we have in `movieData` array.

```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // we need as many rows as there are Movie objects in our movieData array
        return self.movieData.count
}
```

#### `cellForRow`:

For every type of cell you create, you'll need to define it's `cellIdentifier` property. The `cellIdentifier` will let `cellForRow` know which kind of cell it will `dequeue` for use. Think of each cell prototype as being a blueprint for how a cell will appear: this includes the *data* it will display along with its overall *layout and design*. When you create a `UITableViewController` in storyboard, it automatically gets a `UITableView` with a single prototype `UITableViewCell` embedded in it. We need to somehow link up this prototype cell from storyboard (where we adjust its *layout and design*) to code (where we determine the *data* it will display). This is the purpose of the `cellIdentifier`! It is possible to have many different types of cells, each one displaying a different type of data (maybe `Movie` in some, `Actor` in another) and having a different design.

Go to the storyboard and select the prototype cell inside of `MovieTableViewController` and give it a cellIdentifier of `MovieTableViewCell` and ensure that it's `style` is set to `Subtitle`:

![Adding a cell identifier and adjusting style](./Images/identifying_cell_storyboard.png)

Now, back in the `MovieTableViewController.swift` file, add (just above `viewDidLoad` a variable to keep track of this identifier. We're going to use this value in just a moment:

```swift
class MovieTableViewController: UITableViewController {

    internal var movieData: [Movie]!
    let cellIdentifier: String = "MovieTableViewCell"

    override func viewDidLoad() {
        // ... the other code ...
    }
```

#### Implementing `cellForRow`

Think of how many movies have been made since cinema began.. likely in the tens of thousands. If Reel Good wants us to display (potentially) all of these movies in this table, that's going to be a lot of `Movie` instances. And each of those instances is going to need its own cell, which itself is an organized set of `UIView`s. The amount of memory needed to store and display all of that data is beyond what an iPhone could handle all at once. So instead, a tableview efficiently manages its cells by only creating as many as it needs to show on the screen at once. So if only 10 cells can be visible at a time on the screen, then only 10 cell exist in memory.

When you scroll up or down, behind the scenes, the table view takes the cell that just scrolled off screen and reuses it! That cell get the data of the next `Movie` object and gets placed at the bottom of the table. In that way, the views are rotated from top to bottom (or vice-versa) as needed. This process of taking a cell that's scrolled off screen and *reusing* it by updating the data it displays before drawing it back on screen is called *dequeueing*.


*Q: How do we get the movie data from our array into each cell, in the proper order?*

Because we can use subscripts to access members of an array, we can use the provided `indexPath` parameter passed into this function to find the right element to display.

An `indexPath` has a `section` property and a `row` property. We know that there will only be 1 section total (because we set it to one in `numberOfSections:`) and that each row will correspond to a single movie object (thanks to `numberOfRowsInSection:`). So by looking at the `row` value of the `indexPath`, we can use that as the subscript value in the movies array.

*Q: How do we actually display the `Movie` text info?*

There are a few built-in `UITableViewCellStyle`s available to us, and this time around we've gone with the `Subtitle` option. Thanks to the documentation, we know we have two text field for use: `textLabel` and `detailTextLabel`.

Let's look at what all this this amounts to in code:

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. dequeue a cell that's no longer on screen, and identify it by "MovieTableViewCell"
        //      - The indexPath here refers to the section & row the cell will occupy.
        //      - In our example, we'll have two indexPaths, corresponding to the numberOfSections
        //      - and numberOfRowsInSection methods:
        //          section 0, row 0
        //          section 0, row 1
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        // 2. We want to grab the index of the movie that corresponds to the row we'll display it on
        let cellMovie = self.movieData[indexPath.row]

        // 3. Now we just add in some text
        cell.textLabel?.text = "\(cellMovie.title) - \(cellMovie.year)"
        cell.detailTextLabel?.text = cellMovie.summary

        // 4. Lastly, we want to return the table view cell we've just updated to be added back to the
        //  table view in its proper position
        return cell
}
 ```

 Run the project let's see what we get!

 ![Final version of the project for part 1](./Images/final_tableview_part1.png)

---

### 6. Coming up!
Excellent! Reel Good absolutely adores our prototype. They only wished that they could see the movie poster art in their cells, and that the cells could expand to accomodate the text from the movie summary. Unfortunately, we tell them:

> [When working with table view cells, you cannot change the layout of the predefined content (for example, the textLabel, detailTextLabel, and imageView properties).](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithSelf-SizingTableViewCells.html)

I guess we'll need to customize the cell! But, this was just a prototype and now there's more to come in version 2!

---

### 7. Exercises

#### Updating `Movie` to use an array of `Actor`

In `Movie`, replace

```swift
    var cast: [String]
```

with:

```swift
    var cast: [Actor]
```

Then, update your implementation of `init(title: String, year: Int, genre: String, cast: [String], locations: [String], summary: String)` to accept `[Actor]` for its `cast` parameter. Doing so will cause your tests to fail, so go ahead and update them to pass with the new changes.

*Advanced*
Don't update the implementation from `cast: [String]` to `cast[Actor]`, keep it the same. Instead, find a way to pass in an array of `String` and parse them out into `Actor` from inside the initializer.

#### Adding new sections

You may have noticed a seperate, unmentioned file in our project: `Data.swift`. There are three data structures to take note of for this example:

```swift
public let firstAndLastTuples: Array<(String, String)>
public let firstAndLastStrings: Array<String>
```
You are to do the following for each of these objects:

1. Add a new cell prototype with unique identifier in storyboard
2. Create a separate section in the table for each
3. Update cells in that section with the information in each of these objects

If you wanted to be diligent, implement `tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?` as well (to separate out the data)

<details><summary>Hint 1</summary>
<br><br>
Recall that we determine the number of sections using <code>numberOfSections</code>
<br><br>
</details>
<br>
<details><summary>Hint 2</summary>
<br><br>
Previously, we weren't concerned about <code>indexPath</code>'s <code>section</code> property. But now we need to use it to determine which section we're in.
<br><br>
</details>
<br>
<details><summary>Hint 3</summary>
<br><br>
It doesn't really matter which cell style you chose.
<br><br>
</details>
<br>
<details><summary>Hint 4</summary>
<br><br>
Its possible to do this task with a single cell prototype. But this isn't necessary.
<br><br>
</details>
<br>
<details><summary>Hint 5</summary>
<br><br>
You'll find using <code>components(separatedBy:)</code> helpful
<br><br>
</details>

![More Sections Solution](./Images/sections_solution.png)

*Advanced*

Do the above but with:

```swift
public let presidentsByYear: Dictionary<Int, String>
```

What makes this tricky is that it is a dictionary. So if you want to preserve a specific order you'll need to do some sorting using it's keys.

![Advanced Sections Solution](./Images/sections_advanced_solution.png)

#### *Advanced*: Adding a new initializer to both `Movie` and `Actor`

Also included in `Data.swift` is an array of dictionarys: `public let movies: [[String:Any]] `. You are to write one new initializer for each `Movie` and `Actor`:

```swift
// Movie
convenience init(from dict: [String : Any])

// Actor
convenience init(from string: String)
```
> NOTE: Be sure to use the new initializer for `Actor` inside of the initializer for `Movie` to correctly create `Actor` objects!!

In the `viewDidLoad` method of `MovieTableViewController`, iterate over `movies` and create new instances of `Movie` using your new initializer. Then add these instances to `var movieData`. Run your project and make sure you can see:

![Advanced Solution](./Images/final_advanced_all_movies_listed.png)

