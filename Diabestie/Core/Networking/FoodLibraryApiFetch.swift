//
//  FoodLibraryApiFetch.swift
//  Diabestie
//
//  Created by Julius Cesario on 13/04/21.
//

import Foundation
//Init variable domain string
private let domainUrlString = "https://us-central1-diabestie.cloudfunctions.net/"

//Init model variable from foodLibrary
struct foodLibrary: Codable {
    let name: String?
    let calories: Int?
    let weight: Int?
    let sugar: Int?
}

//Init Class Food Manager
final class FoodManager {
    //function fetch foods from API
    func fetchFoods(completionHandler: @escaping ([foodLibrary]) -> Void) {
        //Init API getFoods from api url
        let url = URL(string: domainUrlString + "getFoods/")!
        //Call API and check if there are error on API
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching foods: \(error)")
                return
            }
                
            //Call API and check if there are error on API
            guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
                
            //get Data and decode it into foodLibrary Model for data handling
            if let data = data{
                let foodData = try? JSONDecoder().decode([foodLibrary].self, from: data)
                completionHandler(foodData ?? [])
            }
        })
        task.resume()
    }
}
