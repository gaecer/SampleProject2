//
//  myRecipiesTests.swift
//  myRecipiesTests
//
//  Created by gaetano cerniglia on 25/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import XCTest
import CoreData

@testable import myRecipies

class RecipeDTOTests: XCTestCase {
    lazy var jsonSampleData: Data = {
        if let path = Bundle.main.path(forResource: "SampleRecipes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                XCTFail("bad json string")
                return Data()
            }
        }
        return Data()
    }()
    
    var recipes = [RecipeDTO]()
    
    override func setUp() {
        do {
            recipes =  try JSONDecoder().decode([RecipeDTO].self, from: jsonSampleData)
        } catch let error {
            XCTFail("\(error)")
        }
    }
    
    /// Test expected values from the mock data present in the json file
    func testRecipe() {
        XCTAssert(recipes.count > 0)
        
        guard let recipe = recipes.first else {
            XCTFail("No recipes found")
            return
        }
        
        XCTAssertEqual(recipe.id, 135)
        XCTAssert(recipe.title == "Almond Cookies")
        XCTAssert(recipe.recipeDescription == "My nonna used to bake ‘pasticcini alle mandorle’ for us when visiting her during the Christmas holidays. These sweet treats are a must for all those who love almonds and they are easy to make. Perfect with your tea in cold winter afternoons. #almond #snack #baking #homemade #cookies #italianfood #italy #ovenbake #teatime #christmas #christmastreats #holidayfood")
        XCTAssertEqual(recipe.stars, 2)
        XCTAssertEqual(recipe.favourites, 4)
        XCTAssertEqual(recipe.likes, 1)
        XCTAssert(recipe.hashtags == "#almond,#snack,#baking,#homemade,#cookies,#italianfood,#italy,#ovenbake,#teatime,#christmas,#christmastreats,#holidayfood")
        if let hashtagsArray = recipe.hashtags?.components(separatedBy: ",#") {
            XCTAssertEqual(hashtagsArray.count, 12)
        } else {
            XCTFail("Wrong Hashtags")
        }
        XCTAssert(recipe.ingredientsStrings == "sugar, cornflour (optional), blanched almonds, egg white, salt, vanilla extract, almond extract , icing sugar")
        if let hashtagsArray = recipe.ingredientsStrings?.components(separatedBy: ", ") {
            XCTAssertEqual(hashtagsArray.count, 8)
        } else {
            XCTFail("Wrong Ingredients")
        }
        XCTAssertEqual(recipe.serves, 12)
        XCTAssertEqual(recipe.cookingTime, 10)
        XCTAssertEqual(recipe.numOfRatings, 9 )
        XCTAssert(recipe.ownerUsername == "Gabriele")
    }
    
}
