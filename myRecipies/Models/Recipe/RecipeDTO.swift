//
//  RecipeDTO.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 28/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import Foundation
/// Recipe Data Transfer Object
struct RecipeDTO {
    var id: Int?
    var title: String?
    var recipeDescription: String?
    var stars: Int?
    var favourites: Int?
    var likes: Int?
    var hashtags: String?
    var ingredientsStrings: String?
    var serves: Int?
    var cookingTime: Int?
    var numOfRatings: Int?
    var ownerUsername: String?
}

extension RecipeDTO: Codable {
    
    enum CodingKeys: String, CodingKey {
            case id
            case title
            case recipeDescription = "description"
            case stars
            case favourites
            case likes
            case hashtags
            case ingredientsStrings
            case serves
            case cookingTime
            case numOfRatings
            case ownerUsername
           }
    
    public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            recipeDescription = try container.decode(String.self, forKey: .recipeDescription)
            stars = try container.decode(Int.self, forKey: .stars)
            favourites = try container.decode(Int.self, forKey: .favourites)
            likes = try container.decode(Int.self, forKey: .likes)
            hashtags = try container.decode(String.self, forKey: .hashtags)
            ingredientsStrings = try container.decode(String.self, forKey: .ingredientsStrings)
            serves = try container.decode(Int.self, forKey: .serves)
            cookingTime = try container.decode(Int.self, forKey: .cookingTime)
            numOfRatings = try container.decode(Int.self, forKey: .numOfRatings)
            ownerUsername = try container.decode(String.self, forKey: .ownerUsername)
           }
}

extension RecipeDTO {
    
    func setupRecipe(_ recipe: Recipe) {
        recipe.id = NSNumber(value: id ?? 0).int32Value
        recipe.title = title
        recipe.recipeDescription = recipeDescription
        recipe.stars = NSNumber(value: stars ?? 0).int16Value
        recipe.favourites = NSNumber(value: favourites ?? 0).int16Value
        recipe.likes = NSNumber(value: likes ?? 0).int16Value
        recipe.hashtags = hashtags
        recipe.ingredientsStrings = ingredientsStrings
        recipe.serves = NSNumber(value: serves ?? 0).int16Value
        recipe.cookingTime = NSNumber(value: cookingTime ?? 0).int16Value
        recipe.numOfRatings = NSNumber(value: numOfRatings ?? 0).int16Value
        recipe.ownerUsername = ownerUsername
    }
    
}
