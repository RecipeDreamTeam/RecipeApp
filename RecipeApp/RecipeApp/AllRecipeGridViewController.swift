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

    var recipes = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    
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
        
        myRefreshControl.addTarget(self, action: #selector(loadRecipes), for: .valueChanged)
        collectionView.refreshControl = myRefreshControl
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadRecipes()

    }
    
    @objc func loadRecipes(){
        let query = PFQuery(className: "Recipes")
        //add author back in when login complete
        //query.includeKeys(["author"])
        query.limit = 20
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (recipes, error) in
            if recipes != nil {
                self.recipes = recipes!
                self.collectionView.reloadData()
                self.myRefreshControl.endRefreshing()
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
        cell.favButton.tag = indexPath.item
        cell.favButton.addTarget(self, action: #selector(self.addFavorite), for: .touchUpInside)
        
        return cell
    }
    
    @objc func addFavorite(sender: UIButton) {
        let favorite = PFObject(className: "Favorites")
        favorite["user"] = PFUser.current()!
        favorite["recipe"] = recipes[sender.tag]
        
        favorite.saveInBackground { (success, error) in
            if success {
                print("saved")
            } else {
                print("error")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (sender is UICollectionViewCell) {
            //send data to details screen
            //find movie info
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)!
            let recipe = recipes[indexPath.item]
            //pass movie to controller
            let detailViewController = segue.destination as! RecipeDetailsViewController
            detailViewController.recipe = recipe
        } else {
            super.prepare(for: segue, sender: sender)
        }

    }

}
    
