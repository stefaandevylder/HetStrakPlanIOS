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
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    let categories = ["ontbijt", "lunch", "diner", "tussendoortje", "voorgerecht", "dessert"]
    
    @IBOutlet weak var tableCategories: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCategories.delegate = self
        tableCategories.dataSource = self
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
        
        cell.categoryImage.image = UIImage(named: category)
        cell.titleView.text = category
        
        //Layout of the cell
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = CGFloat(10)
        cell.layer.borderColor = tableView.backgroundColor?.cgColor
        
        
        return cell
    }
    
    /**
     When a section is tapped.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.row).")
    }
    
}
