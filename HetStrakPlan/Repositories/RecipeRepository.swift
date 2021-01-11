//
//  RecipeRepository.swift
//  HetStrakPlan
//
//  Created by Stefaan De Vylder on 08/01/2021.
//

import UIKit
import SQLite

class RecipeRepository {
    
    private var RECIPES_URL = "https://europe-west1-hetstrakplan.cloudfunctions.net/api/recepten"
    private var _recipes: [Recipe] = []
    
    private var _database: Connection!
    private var _likedRecipes = Table("likedRecipe")
    private var _title = Expression<String>("title")
    
    /**
     We open the connection to the database, then we fetch all recipes from the web.
     */
    init () {
        createConnection()
        fetchNewRecipes()
    }
    
    /**
     Creates the file for the SQLite DB and than opens connection.
     Also creates the table.
     */
    private func createConnection() {
        do {
            //Create database file
            let documentDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDir.appendingPathComponent("likedRecipe").appendingPathExtension("sqlite3")
            
            //Open database connection
            _database = try Connection(fileURL.path)
            
            //Create database table if not existant
            try _database.run(_likedRecipes.create { t in
                t.column(_title, primaryKey: true)
            })
        } catch {
            print(error)
        }
    }
    
    /**
     Fetch new recipes from the URL.
     */
    private func fetchNewRecipes() {
        let url = URL(string: RECIPES_URL)!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                if let recipes: [Recipe] = try? decoder.decode([Recipe].self, from: data) {
                    self._recipes = recipes
                }
            }
        }.resume()
    }
    
    /**
     Get all recipes from cache.
     */
    public func getAllRecipes() -> [Recipe] {
        return _recipes
    }
    
    /**
     Get all recipes by category from cache.
     */
    public func getRecipes(category: String) -> [Recipe] {
        return _recipes.filter { $0.categories.contains(category) }
    }
    
    /**
     Get all recipes by category from cache.
     */
    public func getLikedRecipes() -> [Recipe] {
        var likedRecipes: [Recipe] = []
        
        do {
            for recipe in try _database.prepare(_likedRecipes) {
                let recipeFound = _recipes.filter { $0.title == recipe[_title] }.first
                
                if recipeFound != nil {
                    likedRecipes.append(recipeFound!)
                }
            }
        } catch {
            print(error)
        }
        
        return likedRecipes
    }
    
    /**
     Add a recipe to the database.
     */
    public func toggleLikedRecipe(recipe: Recipe) {
        do {
            if (!getLikedRecipes().contains { recipe.title == $0.title }) {
                try _database.run(_likedRecipes.insert(_title <- recipe.title))
            } else {
                let recipeToDelete = _likedRecipes.filter(_title == recipe.title)
                try _database.run(recipeToDelete.delete())
            }
        } catch {
            print(error)
        }
    }
}
