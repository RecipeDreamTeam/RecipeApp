Original App Design Project
===

# APP_NAME_HERE

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
[Description of your app]

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
- **Mobile:**
- **Story:**
- **Market:**
- **Habit:**
- **Scope:**

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
   * Stretch Goal: Filtering capability
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

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* [list first screen here]
   * [list screen navigation here]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes

***Here are the wireframes of the MVP we described above:***

Landing Page with Collection of Recipes:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/wireframe%20photos%20and%20gifs/wireframe%20main%20page.jpg" width=600><br>

Details Page for a Single Recipe:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/wireframe%20photos%20and%20gifs/wireframe%20detail%20%20view.jpg" width=600><br>

Add Recipe Modal:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/wireframe%20photos%20and%20gifs/wireframe%20add%20recipe%20modal.jpg" width=600><br>

Wireframe Flow:

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/wireframe%20photos%20and%20gifs/wireframes%20with%20flows.jpg" width=600><br>

### [x] [BONUS] Digital Wireframes & Mockups

See Above that wireframes are digital.

### [x] [BONUS] Interactive Prototype

<img src="https://github.com/RecipeDreamTeam/RecipeApp/blob/main/wireframe%20photos%20and%20gifs/wireframe%20walkthrough.gif" width=600><br>

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
