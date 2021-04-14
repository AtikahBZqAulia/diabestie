//
//  FoodLibraries+CoreDataClass.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 13/04/21.
//
//

import Foundation
import CoreData

@objc(FoodLibraries)
public class FoodLibraries: NSManagedObject {
    
    func update(with jsonDictionary: [String: Any]) throws {
        guard let name = jsonDictionary["name"] as? String,
              let weight = jsonDictionary["weight"] as? Int,
              let calories = jsonDictionary["calories"] as? Int,
              let sugar = jsonDictionary["sugar"] as? Int
        else {
            throw NSError(domain: "", code: 100, userInfo: nil)
        }
        
        self.food_name = name
        self.weight = Int32(weight)
        self.calories = Int32(calories)
        self.sugar = Int32(sugar)
        self.created_at = Date()
        self.updated_at = Date()
    }
    
    func update(with jsonDictionary: foodLibrary) throws {
        guard let name = jsonDictionary.name,
              let weight = jsonDictionary.weight,
              let calories = jsonDictionary.calories,
              let sugar = jsonDictionary.sugar
        else {
            throw NSError(domain: "", code: 100, userInfo: nil)
        }
        
        self.food_name = name
        self.weight = Int32(weight)
        self.calories = Int32(calories)
        self.sugar = Int32(sugar)
        self.created_at = Date()
        self.updated_at = Date()
    }
}
