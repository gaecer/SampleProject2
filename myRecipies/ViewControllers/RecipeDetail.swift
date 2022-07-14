//
//  RecipeDetail.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 27/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import SwiftUI

struct RecipeDetail: View {
    var recipe: Recipe
    var imgURL = String()
    var img = UIImageView()
    var body: some View {
        VStack(alignment: .center) {
            Text(recipe.hashtags ?? "").padding(.bottom, 10)
            
            HStack {
                Text("Username:").font(.subheadline)
                Text(recipe.ownerUsername ?? "")
                Text("\(recipe.stars)")
            }
            HStack {
                Text("Serves:")
                Text("\(recipe.serves)")
                Text("Likes:")
                Text("\(recipe.likes)")
                Text("Ratings:")
                Text("\(recipe.numOfRatings)")
            }
            HStack {
                Text("Cooking Time:")
                Text("\(recipe.cookingTime)\(recipe.cookingTime == 1 ? "min" : "mins")")
            }
            
            Text(recipe.recipeDescription ?? "").padding(.vertical, 25)
            
            Text("Ingredients:").fontWeight(.bold)
            Text(recipe.ingredientsStrings ?? "")
            Spacer()
        }.padding(.horizontal, 20).navigationBarTitle(recipe.title ?? "")
    }
}

#if DEBUG
import CoreData

struct RecipeDetail_Previews: PreviewProvider {  
    static var previews: some View {
        let entity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["Recipe"]
        let recipe = Recipe(entity: entity!, insertInto: nil)
        recipe.hashtags = "#dessert,#eggs"
        recipe.ownerUsername = "Gabriele"
        recipe.stars = 5
        recipe.serves = 1
        recipe.likes = 50
        recipe.numOfRatings = 50
        recipe.cookingTime = 10
        recipe.recipeDescription = "The perfect accompaniement to any desserts.  #dessert #eggs"
        recipe.ingredientsStrings = "\n6 eggs yolks\n1/2 tsp vanilla extract\n75g sugar\n500ml whole milk\n1 dollop double cream"
        recipe.title = "Creme Anglaise"
        return RecipeDetail(recipe: recipe)
    }
}
#endif
