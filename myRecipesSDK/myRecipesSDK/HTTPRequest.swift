//
//  DataService.swift
//  StackOverflowUsers
//
//  Created by Gaetano Cerniglia on 19/10/2019.
//  Copyright © 2019 Gaetano Cerniglia. All rights reserved.
//

import Foundation

// MARK: - Error Enumeration
public enum DataServiceError: Error {
    case fileNotFound
    case malformedJson
    case invalidURL
    case invalidResponse
    case noNetwork
    case other(String)
}

private let baseURL = "http://178.62.122.30:3000/api/"
private let defaultParams = "?filter[where][draft]=false&[where][hidden]=false&[where][banned]=false&filter[order]=date%20DESC"

public class HTTPRequest {
    
    public static func fetchData <T: Decodable>(
                        endpoint: String,
                        type: T.Type,
                        skip: Int = 0,
                        limit: Int = 10,                        
                        completion: @escaping ([T]?, DataServiceError?) -> Void)
    {
        guard
            let url = URL(string: "\(baseURL)/\(endpoint)?\(defaultParams)&filter[limit]=\(limit)&filter[skip]=\(skip)")
        else {
            completion(nil, .invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error as NSError? {
                if error.code == -1009 {
                    completion(nil, .noNetwork)
                    return
                } else {
                    completion(nil, .other(error.localizedDescription))
                    return
                }
            }

            // successful
            do {
                let dataObject = try JSONDecoder().decode([T].self, from: data!)
                completion(dataObject, nil)
            } catch let jsonError {
                print("Nil data received from fetchAllRooms service", jsonError)
                completion(nil, .malformedJson)
            }
        }.resume()
    }
}
