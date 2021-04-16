//
//  FoodLibraryApiFetch.swift
//  Diabestie
//
//  Created by Julius Cesario on 13/04/21.
//

import Foundation
import CoreData

//Init variable domain string
private let domainUrlString = "https://us-central1-diabestie.cloudfunctions.net/"

//Init model variable from foodLibrary
struct foodLibrary: Codable {
    let name: String?
    let calories: Int?
    let weight: Int?
    let sugar: Int?
}

final class ApiRepository {

    func fetchFoods(completion: @escaping (_ foodLibrary: [foodLibrary]?, _ error: Error?) -> Void) {

        let url = URL(string: domainUrlString + "getFoods/")!

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching foods: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "dataErrorDomain", code: 101, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
                let jsonObject = try? JSONDecoder().decode([foodLibrary].self, from: data)

                guard let result = jsonObject else {
                    throw NSError(domain: "dataErrorDomain", code: 100, userInfo: nil)
                }
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }).resume()
        
    }
}
