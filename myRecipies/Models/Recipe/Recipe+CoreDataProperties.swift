//
//  Recipe+CoreDataProperties.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 28/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//
//

import Foundation
import CoreData

/// Rapresentation of the Recipe object stored in the Database
extension Recipe {
    /**
    Private function to retrieve all the Recipe objects from the database

    - returns:
     NSFetchRequest<Recipe>  a fetch request of type Recipe coming from the entity in the database called Recipe
     
     
    */
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var ownerUsername: String?
    @NSManaged public var numOfRatings: Int16
    @NSManaged public var cookingTime: Int16
    @NSManaged public var date: Date?
    @NSManaged public var serves: Int16
    @NSManaged public var ingredientsStrings: String?
    @NSManaged public var hashtags: String?
    @NSManaged public var likes: Int16
    @NSManaged public var favourites: Int16
    @NSManaged public var stars: Int16
    @NSManaged public var recipeDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int32
    @NSManaged public var data: Data?

}
