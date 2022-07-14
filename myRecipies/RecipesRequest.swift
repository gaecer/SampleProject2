//
//  RecipesRequest.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 29/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import Foundation
import myRecipesSDK

typealias RecipeRequestResult = Result<[RecipeDTO], DataServiceError>
typealias RecipeRequestResultCompletion = (RecipeRequestResult) -> Void

class RecipeRequest {
    
    private(set) var skip: Int
    let limit: Int
    private var completionHandler: RecipeRequestResultCompletion?
    private let kEndpoint = "recipes"
    
    init(skip: Int, limit: Int, completionHandler: @escaping RecipeRequestResultCompletion) {
        self.skip = skip
        self.limit = limit
        self.completionHandler = completionHandler
    }
    
    /**
         Retrieves all the data from the Recipe end-point paginated by a limit of records

         - returns:
         no returns
          
          - parameters:
             - no parameters
   */
    func start() {
        HTTPRequest.fetchData(endpoint: kEndpoint, type: RecipeDTO.self, skip: skip, limit: limit) { [weak self] (result, error) in
            guard let strongSelf = self else { return }

            if let error = error {
                DispatchQueue.main.async {
                    strongSelf.completionHandler?(Result.failure(error))
                    strongSelf.completionHandler = nil
                }
                return
            }
            guard let recipeDTOs = result else {
                DispatchQueue.main.async {
                    strongSelf.completionHandler?(Result.failure(.malformedJson))
                    strongSelf.completionHandler = nil
                }
                return
            }

            DispatchQueue.main.async {
                strongSelf.completionHandler?(Result.success(recipeDTOs))
                strongSelf.completionHandler = nil
            }
        }
    }
    
}
