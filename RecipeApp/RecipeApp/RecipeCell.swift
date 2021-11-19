//
//  RecipeCollectionViewCell.swift
//  RecipeApp
//
//  Created by Lauren Work on 11/5/21.
//

import UIKit
import Parse

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    
    @IBAction func favoriteRecipe(_ sender: Any) {
//        let toBeFavorited = !favorited
//        if (toBeFavorited) {
//            self.setFavorite(true)
//        } else {
////            self.setFavorite(false)
//        }
    }
}
