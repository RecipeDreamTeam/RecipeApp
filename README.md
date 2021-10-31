Original App Design Project
===

# Collabo-Recipe

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Enables user to scroll and view various recipes, and possibly allow users to be able to filter recipes by category of interest.

### App Evaluation

- **Category:** Food & Drink
- **Mobile:**  This app will be primarily developed for mobile use, but would perhaps be just as viable on a computer. 
- **Story:**  Users can view and scroll through recipes, click on recipe for more details, and can add recipe to database if wanted. 
- **Market:**  Any individual looking for recipe ideas & recommendations. 
- **Habit:**  This app can be used as often as needed, depending on whenever the user may need recipe guidance. 
- **Scope:**  Initially, we would start with allowing people to view, scroll, and look at different recipes. We could then potentially evolve the app into allowing users to create profiles, save recipes to their profiles, and also filter recipes by different categories such as appetizers, main dishes, and desserts, or by food type like italian food recipes or mexican food recipes, or by highly favorited recipes. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can view and scroll through a list of recipes
* User can click on a recipe to get detailed recipe
* User can add a recipe to database

**Optional Nice-to-have Stories**

* User can create a profile
* User can favorite and save recipes to their profile
* User can filter recipes by category

### 2. Screen Archetypes

* Landing Page
   * CollectionView of Recipes available to Scroll through
   * Infinite scroll available and Pull to Refresh
   * Pressing any recipe image loads detail view screen
   * Pressing the plus in the top right corner loads the form to submit a new recipe
   * Stretch Goal: Filtering capability by food type, food category, or highly favorited recipes
* Detail View Screen
   * When recipe is clicked in collection view, view with details will show
   * Option to exit out of detail and return to collection view when clicking x in top right corner
* Add Recipe Modal
   * When the plus icon is pressed in the main screen, the add recipe modal will slide up
   * This will have the option to take a picture and add text and press submit to submit a recipe to the database
   * After submission of the form, the user will be returned to the collection view
* Stretch Story: Profile login
   * Login Screen as initial view with username and password fields
   * Option to login or sign up
   * Successful login or signup leads to collection view recipe screen
* Stretch Story: Profile Screen
   * Profile Screen lists recipes you have favorited
   * Screen accessed by second button in menu bar with profile icon
* Stretch Story: Ability to favorite recipes in collectionview and detail view
   * Pressing favorite button will show favorite icon change color
   * Favorited items can be viewed in profile screen

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Recipes
* Profile (stretch goal)

**Flow Navigation** (Screen to Screen)

* Collection of recipes
   * "+" Bar button navigation modally presents "Add recipe" screen
   * Scroll to see continuous grid of suggested recipes
   * Click on a recipe to proceed to details page for selected recipe
* Recipe Details page
   * "Back" Bar button navigation returns to collection page
* Add recipe page
   * "Back" bar button returns user to collection page
   * "Submit" button adds recipe to collection and returns user to collection page
* Login page
   * "Login" or "Sign Up" when successful proceeds to collection page
* Profile page
   * "+" Bar button navigation modally presents "Add recipe" screen
   * Click on a recipe to proceed to details page for selected recipe

## Wireframes

***Here are the wireframes of the MVP we described above:***

Login Page - Initial ViewHolder:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/login%20wireframe.jpg" width=600><br>

Profile Page with Recipes User has Liked:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/profile%20wireframe.jpg" width=600><br>

Landing Page with Collection of Recipes:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/landing%20page%20wireframe.jpg" width=600><br>

Details Page for a Single Recipe:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/detail%20view%20recipe%20wireframe.jpg" width=600><br>

Add Recipe Modal:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/add%20recipe%20wireframe.jpg" width=600><br>

Wireframe Flow - see interactive prototype below for better visualization of where to click to move between screens:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/wireframe%20flow.jpg" width=600><br>

### [x] [BONUS] Digital Wireframes & Mockups

See Above that wireframes are digital.

### [x] [BONUS] Interactive Prototype

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/interactive%20walkthrough.gif" width=600><br>

## Schema 

The objects in our app are the recipes and the users.

### Models

#### Model: Recipe

| Property | Type | Description |
|--------|----|-----|
| objectId | String | unique id for the recipe (default field) |
| author | Pointer to User | recipe author |
| image | File | image for recipe |
| directions | String | Recipe directions provided by author |
| createdAt | DateTime | date when recipe was created (default field) |
| updatedAt | DateTime | date when recipe was last updated (default field) |

#### Model: User

| Property | Type | Description |
|--------|----|-----|
| objectId | String | unique id for the recipe (default field) |
| username | String | user's username |
| password | String | user's password |
| favorites | Array of pointers to Recipes | List of favorited recipes for this user |
| createdAt | DateTime | date when recipe was created (default field) |
| updatedAt | DateTime | date when recipe was last updated (default field) |

### Networking
- Login Screen **Allison to add code snippets**
  - (Create/POST) Log In
```
  @IBAction func onSignIn(_ sender: Any) {
      let username = usernameField.text!
      let password = passwordField.text!

      PFUser.logInWithUsername(inBackground: username, password: password) {
          (user, error) in
          if user != nil {
              self.performSegue(withIdentifier: "loginSegue", sender: nil)
          } else {
              print("Error: \(error?.localizedDescription)")
          }
      }
  }
```
  - (Create/POST) Sign Up
```
  @IBAction func onSignUp(_ sender: Any) {
      let user = PFUser()
      user.username = usernameField.text
      user.password = passwordField.text

      user.signUpInBackground{(success, error) in
          if success {
              self.performSegue(withIdentifier: "loginSegue", sender: nil)
          } else {
              print("Error: \(error?.localizedDescription)")
          }
      }
  }
````
- Profile Screen **Allison to add code snippets**
  - (Read/GET) Query for all recipes favorited by user
```
let query = PFQuery(className: "Recipes")
query.includeKey("author")
query.includeKey("favorites")
        
query.findObjectsInBackground { (posts, error) in
    if posts != nil {
        self.posts = posts!
        self.tableview.reloadData()
    }
}
```

  - (Update/PUT) Update list of favorites to take out recipe
```
let query = PFQuery(className: "User")

query.getObjectInBackgroundWithId:@objectId { (user, error) in
    if recipe != nil {
      self.user["favorites"].pop(recipeObjectId) // confirm syntax
```
- Landing Screen with grid of Recipes **Soman to add code snippets**
  - (Read/GET) Query for list of recipes by any user
```
let query = PFQuery(className: "Recipes")
query.limit = 20
        
query.findObjectsInBackground { (posts, error) in
    if posts != nil {
        self.posts = posts!
        self.tableview.reloadData()
    }
}
```
  - (Update/PUT) Add recipe to user's favorite list of recipes when user hits favorite button
```
let query = PFQuery(className: "User")

query.getObjectInBackgroundWithId:@objectId { (user, error) in
    if recipe != nil {
      self.user["favorites"].append(recipeObjectId) // confirm syntax
```

- Detail Screen for Details on One Recipe 
  - (Read/GET) Query for full details on specific recipe
```
let query = PFQuery(className: "Recipes")
query.includeKey("objectId")
        
query.findObjectsInBackground { (posts, error) in
    if posts != nil {
        self.posts = posts!
        self.tableview.reloadData()
    }
}
```
  - (Update/PUT) Add recipe to user's favorite list of recipes when user hits favorite button
```
let query = PFQuery(className: "User")

query.getObjectInBackgroundWithId:@objectId { (user, error) in
    if recipe != nil {
      self.user["favorites"].append(recipeObjectId) // confirm syntax
```


- Create Recipe Modal
  - (Create/POST) Create a new recipe when user taps submit button  
 ```   
  @IBAction func onSubmitButton(_ sender: Any) {
        let recipe = PFObject(className: "Recipe")
        
        recipe["directions"] = directionsField.text!
        recipe["author"] = PFUser.current()!
        
        let imageData = imageView.image?.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("posted.")
            } else {
                print("error.")
            }
        }
    }
```
