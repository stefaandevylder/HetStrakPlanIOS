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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0))
    }
    
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        
        //Design for content view in the cell
        cell.backgroundColor = UIColor.init(named: "LightColor")
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.shadowColor = UIColor.gray.cgColor
        cell.contentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.contentView.layer.shadowRadius = 7.0
        cell.contentView.layer.shadowOpacity = 0.8
        
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
