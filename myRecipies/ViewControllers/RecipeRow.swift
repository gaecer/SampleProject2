//
//  RecipeRow.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 26/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import SwiftUI

/// Recipe single row View
struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(recipe.title ?? "")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                Spacer()
            }.padding(.bottom, 4)
            Text(recipe.recipeDescription ?? "")
                .padding(.bottom, 16)
        }.padding(.horizontal, 22)
        .padding(.top, 8)
    }
}

#if DEBUG
import CoreData

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        let entity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["Recipe"]
        let recipe = Recipe(entity: entity!, insertInto: nil)
        recipe.recipeDescription = "The perfect accompaniement to any desserts.  #dessert #eggs"
        recipe.title = "Creme Anglaise"
        return RecipeRow(recipe: recipe)
    }
}
#endif
