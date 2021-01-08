//
//  ProductsViewController.swift
//  HetStrakPlan
//
//  Created by Stefaan De Vylder on 08/01/2021.
//

import UIKit

class ProductsViewController: UIViewController {

    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        category = self.title!
    }
    
}
