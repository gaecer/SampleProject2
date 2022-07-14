//
//  RecipeListVM.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 25/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import Foundation
import CoreData
import myRecipesSDK

class RecipesListViewModel: ObservableObject {

    private let context: NSManagedObjectContext
    var viewDidLoad = false
    @Published var recipes = [Recipe]()
    @Published var errorOccurred = false
    var error: DataServiceError?
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    /**
      Retrieves all the recipes from the DataProvider to set the local variable recipes

      - returns:
      no returns
       
       - parameters:
          - no parameters
       
    */
    func fetchRecipes() {
        DataProvider.shared.getAllRecipes(completion: { (result, online) in
            if online {
                self.recipes.append(contentsOf: result)
            } else {
                self.recipes = result
            }
        })
    }
}
