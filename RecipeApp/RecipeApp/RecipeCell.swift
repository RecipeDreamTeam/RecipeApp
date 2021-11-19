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
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            self.setFavorite(true)
        } else {
//            self.setFavorite(false)
        }
    }
    
    var favorited:Bool = false
    var recipeId:String = ""
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
            print("Favorited")
        } else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            print("Unfavorited")
        }
    }

}
