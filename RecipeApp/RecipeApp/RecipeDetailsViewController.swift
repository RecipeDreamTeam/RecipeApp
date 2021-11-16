//
//  RecipeDetailsViewController.swift
//  RecipeApp
//
//  Created by Soman Khan on 11/12/21.
//

import UIKit
import AlamofireImage
import Parse

class RecipeDetailsViewController: UIViewController {
    
    var recipe: PFObject!
    
    
    @IBOutlet weak var detailRecipeImageView: UIImageView!
    @IBOutlet weak var detailRecipeTitleView: UILabel!
    @IBOutlet weak var detailRecipeDirectionsView: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .purple
        navigationController?.navigationBar.tintColor = .white

        detailRecipeTitleView.text = recipe["title"] as? String
        detailRecipeDirectionsView.text = recipe["directions"] as? String
        
        let imageFile = recipe["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        detailRecipeImageView.af.setImage(withURL: url)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
