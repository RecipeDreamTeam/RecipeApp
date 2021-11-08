//
//  AllRecipeGridViewController.swift
//  RecipeApp
//
//  Created by Lauren Work on 11/5/21.
//

import UIKit
import AlamofireImage
import Parse

class AllRecipeGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    //need to replace with array of PFObjects when API call to get recipes is set up
    var recipes = [PFObject]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let width = (view.frame.size.width - (layout.minimumInteritemSpacing)) / 2
        
        
        layout.itemSize = CGSize(width: width, height: width*1.2)

        //placeholder data structure holding recipes until we have api call to get this
//        for i in 1...20 {
//            //create recipe
//            let title = "Test \(i)"
//            let image = UIImage(named: "rice-png")!
//            let recipe = Recipe(givenTitle: title, givenImage: image)
//            recipes.append(recipe)
//            collectionView.reloadData()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Recipe")
        query.includeKeys(["author"])
        query.limit = 20
        
        query.findObjectsInBackground { (recipes, error) in
            if recipes != nil {
                self.recipes = recipes!
                self.collectionView.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
        //need to switch out final config when we have recipe PFObjects
        let recipe = recipes[indexPath.item]
        let title = recipe["title"] as? String
        
        let imageFile = recipe["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.recipeTitleLabel.text = title
        cell.recipeImageView.af.setImage(withURL: url)
        
        return cell
    }

}
