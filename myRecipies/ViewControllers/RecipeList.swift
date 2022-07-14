//
//  ContentView.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 25/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import SwiftUI

struct RecipeList: View {
    
    @ObservedObject var viewModel: RecipesListViewModel
    var body: some View {
        NavigationView {
            List(viewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                    RecipeRow(recipe: recipe)
                }                
            }.onAppear(){
                if !self.viewModel.viewDidLoad {
                    self.viewModel.viewDidLoad = true
                    self.viewModel.fetchRecipes()
                }
            }.alert(isPresented: $viewModel.errorOccurred) {
                Alert(title: Text("Error occurred"),
                      message: Text(viewModel.error?.localizedDescription ?? "Some error occurred"),
                      dismissButton: .default(Text("Ok"), action: {
                        self.viewModel.errorOccurred = false
                      }))
            }
            .navigationBarTitle("Recipes")
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.fetchRecipes()
            }, label: {
                Text("Load More")
            }))
        }
    }
    
}

#if DEBUG
import CoreData
struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        let entity = NSManagedObjectModel.mergedModel(from: nil)?.entitiesByName["Recipe"]
        let recipe = Recipe(entity: entity!, insertInto: nil)
        recipe.recipeDescription = "The perfect accompaniement to any desserts.  #dessert #eggs"
        recipe.title = "Creme Anglaise"
        let recipesListVM = RecipesListViewModel(context: NSManagedObjectContext.current)
        recipesListVM.recipes.append(contentsOf: [recipe, recipe, recipe, recipe, recipe, recipe, recipe])
        return RecipeList(viewModel: recipesListVM)
    }
}
#endif
