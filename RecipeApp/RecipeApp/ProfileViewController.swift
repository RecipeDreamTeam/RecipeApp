//
//  ProfileViewController.swift
//  RecipeApp
//
//  Created by Lauren Work on 11/16/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var favorites = [PFObject]()
    let myRefreshControl = UIRefreshControl()
    
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
        //rewrite query for only user liked recipes when favorites exist in parse
//        let query = PFQuery(className: "Recipes")
//        query.limit = 20
//        query.order(byDescending: "createdAt")
//
//        query.findObjectsInBackground { (recipes, error) in
//            if recipes != nil {
//                self.recipes = recipes!
//                self.collectionView.reloadData()
//                self.myRefreshControl.endRefreshing()
//            }
//        }
        
        let query2 = PFQuery(className: "Favorites")
        query2.whereKey("user", equalTo: PFUser.current())
        query2.includeKeys(["recipe"])
        query2.order(byDescending: "createdAt")
        query2.findObjectsInBackground { favorites, error in
            if favorites != nil {
                self.favorites = favorites!
                self.collectionView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileRecipeCell", for: indexPath) as! ProfileRecipeCell

        //need to switch out final config when we have recipe PFObjects
        let favorite = favorites[indexPath.item]
        let recipe = favorite["recipe"] as! PFObject
        let title = recipe["title"] as? String

        let imageFile = recipe["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!

        cell.profileRecipeTitle.text = title
        cell.profileRecipeImageView.af.setImage(withURL: url)

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (sender is UICollectionViewCell) {
            //send data to details screen
            //find movie info
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)!
            let favorite = favorites[indexPath.item]
            let recipe = favorite["recipe"] as! PFObject
            //pass movie to controller
            let detailViewController = segue.destination as! RecipeDetailsViewController
            detailViewController.recipe = recipe
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController =
            main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let
                delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }

    
    
}
