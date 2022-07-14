//
//  Recipe+CoreDataClass.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 28/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//
//

import Foundation
import CoreData


public class Recipe: NSManagedObject {
    
    /**
    Private function to retrieve all the Recipe objects from the database

    - returns:
    [Recipe] An array of recipes.
     
     - parameters:
        - context:  the current NSManagedObjectContext
     
    */
    public class func getAll(using context: NSManagedObjectContext) -> [Recipe] {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        var result = [Recipe]()
        context.performAndWait {
            if  let fetched = try? context.fetch(fetchRequest) {
                result.append(contentsOf: fetched)
            }
        }
        return result
    }

}

extension Recipe: Identifiable {}
