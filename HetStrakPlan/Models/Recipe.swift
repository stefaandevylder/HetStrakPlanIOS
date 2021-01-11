//
//  Recipe.swift
//  HetStrakPlan
//
//  Created by Stefaan De Vylder on 08/01/2021.
//

import UIKit

struct Recipe: Decodable {
    
    let title: String
    let categories: [String]
    let people: String
    let handle: String
    let created: String
    let ingredients: [String]
    let steps: [String]
    let imageUrl: URL
    
    enum CodingKeys : String, CodingKey {
        case title = "titel",
             categories = "categorie",
             people = "personen",
             handle,
             created = "aangemaaktOp",
             ingredients = "ingredienten",
             steps = "werkwijze",
             imageUrl = "fotoUrl"
    }

}
