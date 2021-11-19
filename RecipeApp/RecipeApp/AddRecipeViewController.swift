//
//  AddRecipeViewController.swift
//  RecipeApp
//
//  Created by Lauren Work on 11/11/21.
//

import UIKit
import AlamofireImage
import Parse

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var recipeTitleField: UITextField!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeDirectionsView: UITextView!
    
    @IBAction func onSubmitRecipe(_ sender: Any) {
        let recipe = PFObject(className: "Recipes")
        recipe["title"] = recipeTitleField.text!
        recipe["directions"] = recipeDirectionsView.text!
        
        
        let imageData = recipeImageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        recipe["image"] = file
        recipe["author"] = PFUser.current()!
        
        recipe.saveInBackground { (success, error) in
            if success {
                print("saved")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error")
            }
        }
        
    }
    
    @IBAction func onClickImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        recipeImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
