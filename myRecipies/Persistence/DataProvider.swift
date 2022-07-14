//
//  DataManager.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 27/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import Foundation
import CoreData
import myRecipesSDK

class DataProvider {
    static let shared = DataProvider(context: NSManagedObjectContext.current)
    private(set) var currentRequest: RecipeRequest?
    private var skip = 0
    private let limit = 10
    private var context: NSManagedObjectContext
    
    private init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    /**
    This function will try to fetch the recipes from the server with in a certain limit.

    - returns:
    The return valuas are passed throw the completion.
     
     Completion:
    * If the request succed the downloaded Recipes are stored into the Database and returned
    * If the request fails for no connectivity, the function will try to recover the data from the Database
    * If the request fails for any other reason, the return will be an empty array
    
     - parameters:
        - completion: [Recipe] An array of Recipe objects.
     
    */
    func getAllRecipes(completion:  @escaping ([Recipe], Bool) -> Void)  {
        let context = self.context
        currentRequest = RecipeRequest(skip: skip, limit: limit, completionHandler: {[weak self] (result) in
            switch result {
            case .failure(let error):
                if case DataServiceError.noNetwork = error {
                    let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
                    context.performAndWait {
                        let fetched = (try? context.fetch(fetchRequest)) ?? [Recipe]()
                        completion(fetched, false)
                    }
                } else {
                    completion([], false)
                }
            case .success(let dtos):
                self?.skip += self?.limit ?? 10
                completion(self?.syncCoreDataCache(recipeDtos: dtos) ?? [Recipe](), true)
            }
        })
        currentRequest?.start()
    }
    
    /**
    Private function to convert DTO recipe objects into Recipe objects

    - returns:
    [Recipe]? An array of recipes.
     
     - parameters:
        - recipeDtos:  [RecipeDTO] An array of RecipeDTO to be converted in array of Recipes
     
    */
    private func syncCoreDataCache(recipeDtos: [RecipeDTO]) -> [Recipe]? {
        var result: [Recipe]? = nil
        context.performAndWait {
            guard !recipeDtos.isEmpty else { return }
            let recipeIds = recipeDtos.map{ $0.id! }
            let fr: NSFetchRequest<NSFetchRequestResult> = Recipe.fetchRequest()
            let predicate = NSPredicate(format: "id IN %@", recipeIds)
            fr.predicate = predicate
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fr)
            
            do {
                try context.execute(deleteRequest)
                result = [Recipe]()
                for dto in recipeDtos {
                    let recipe = Recipe(context: context)
                    dto.setupRecipe(recipe)
                    result!.append(recipe)
                }
                try! context.save()
                
            } catch let error {
                print("Could not delete existing records: \(error)")
                return
            }
        }
        return result
    }
}
