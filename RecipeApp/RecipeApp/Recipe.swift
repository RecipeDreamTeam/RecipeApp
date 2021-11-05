//
//  Recipes.swift
//  RecipeApp
//
//  Created by Lauren Work on 11/5/21.
//

import Foundation
import UIKit

class Recipe {
    //probably going to need to change out type for image to url or something and then use alamo fire image to import when using?
    var image: UIImage
    var title: String
    
    init(givenTitle: String, givenImage: UIImage) {
        self.title = givenTitle
        self.image = givenImage
    }
}
