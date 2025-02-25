//
//  ViewController.swift
//  HetStrakPlan
//
//  Created by Stefaan De Vylder on 05/01/2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    /**
     Additional design for our table cells.
     */
    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = UIColor.init(named: "LightColor")
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0))
        contentView.layer.cornerRadius = 10
    }
    
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recipeRepository: RecipeRepository?
    
    var categories = ["Ontbijt", "Lunch", "Diner", "Tussendoortje", "Voorgerecht", "Dessert", "Favorieten"]
    var selectedCategory: String?
    
    @IBOutlet weak var tableCategories: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCategories.delegate = self
        tableCategories.dataSource = self
        
        recipeRepository = RecipeRepository()
    }

    /**
     Sets the amount of items in the list.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categories.count)
    }
    
    /**
     Inserts the data & sets the layout options.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        let category = categories[indexPath.row]
        
        cell.categoryImage.image = UIImage(named: category.lowercased())
        cell.titleView.text = category
        
        return cell
    }
    
    /**
     When a section is tapped.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]

        performSegue(withIdentifier: "segueToProducts", sender: self)
    }
    
    /**
     Passing data between viewcontrollers.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToProducts" {
            let productsViewController = segue.destination as! ProductsViewController

            productsViewController.recipeRepository = recipeRepository
            productsViewController.title = selectedCategory
            
            if selectedCategory == "Favorieten" {
                productsViewController.recipes = recipeRepository?.getLikedRecipes() ?? []
            } else {
                productsViewController.recipes = recipeRepository?.getRecipes(category: selectedCategory!) ?? []
            }
        }
    }
    
}
