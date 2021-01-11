//
//  ProductDetailViewController.swift
//  HetStrakPlan
//
//  Created by Stefaan De Vylder on 11/01/2021.
//

import UIKit
import Kingfisher

class RecipeDetailsCell: UITableViewCell {
    
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var steps: UILabel!
    
}

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recipeRepository: RecipeRepository?
    var recipe: Recipe?
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeDetailsTable: UITableView!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeDetailsTable.delegate = self
        recipeDetailsTable.dataSource = self
        
        if let r = recipe {
            recipeImage.kf.setImage(with: r.imageUrl)
            recipeTitle.text = r.title
            
            if recipeRepository?.getLikedRecipes().filter({ $0.title == r.title }).first != nil {
                likeButton.setTitle("💗", for: .normal)
            }
        }
    }
    
    /**
    Toggle the liked recipe status.
     */
    @IBAction func toggleLikedRecipe(_ sender: Any) {
        recipeRepository?.toggleLikedRecipe(recipe: self.recipe!)
        
        if likeButton.titleLabel?.text != "💗" {
            likeButton.setTitle("💗", for: .normal)
        } else {
            likeButton.setTitle("🖤", for: .normal)
        }
    }
    
    /**
     Sets the amount of items in the list.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /**
     Inserts the data & sets the layout options.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeDetailsCell", for: indexPath) as! RecipeDetailsCell
        
        cell.ingredients.text = recipe!.ingredients.joined(separator: "\n")
        cell.steps.text = recipe!.steps.joined(separator: "\n")
       
        return cell
    }
}
