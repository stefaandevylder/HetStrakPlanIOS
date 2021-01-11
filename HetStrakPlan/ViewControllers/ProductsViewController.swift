//
//  ProductsViewController.swift
//  HetStrakPlan
//
//  Created by Stefaan De Vylder on 08/01/2021.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    /**
     Additional design for our table cells.
     */
    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = UIColor.init(named: "LightColor")
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        contentView.layer.cornerRadius = 10
    }
}

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recipeRepository: RecipeRepository?
    var recipes: [Recipe] = []
    var selectedRecipe: Recipe?
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
    }
    
    /**
     Sets the amount of items in the list.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipes.count)
    }
    
    /**
     Inserts the data & sets the layout options.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! ProductTableViewCell
        let recipe = recipes[indexPath.row]
        
        cell.productImageView.kf.setImage(
            with: recipe.imageUrl,
            options: [
                .transition(.fade(1)),
            ]
        )
        
        cell.titleLabel.text = recipe.title
        cell.peopleLabel.text = recipe.people
        
        return cell
    }
    
    /**
     When a section is tapped.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = recipes[indexPath.row]
        
        performSegue(withIdentifier: "segueToProductDetails", sender: self)
    }
    
    /**
     Passing data between viewcontrollers.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToProductDetails" {
            let productDetailViewController = segue.destination as! ProductDetailViewController

            productDetailViewController.recipeRepository = recipeRepository
            productDetailViewController.recipe = selectedRecipe
        }
    }
}
