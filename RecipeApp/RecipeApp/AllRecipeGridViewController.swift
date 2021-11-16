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
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send data to details screen
        
        //find movie info
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let recipe = recipes[indexPath.item]
        //pass movie to controller
        let detailViewController = segue.destination as! RecipeDetailsViewController
        detailViewController.recipe = recipe
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //Get the new view controller using segue.destination.
//       // Pass the selected object to the new view controller.
//
//       // Find the selected recipe
//       let cell = sender as! UICollectionViewCell
//       let indexPath = collectionView.indexPath(for:
//       cell)!
//       let recipe = recipes[indexPath.row]
//
//       // Pass the selected movie to the details view controller
//       let detailsViewController = segue.destination as! RecipeDetailsViewController
//        
//        print(recipe)
//       detailsViewController.recipe = recipe
//
//
////       collectionView.deselectRow(at: indexPath, animated: true)
//    }


}
    
