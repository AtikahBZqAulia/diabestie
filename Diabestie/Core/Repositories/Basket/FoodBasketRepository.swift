//
//  MedicineBasket.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class FoodBasketRepository {
    
    static let shared = FoodBasketRepository()
    let entityName = FoodBasket.self.description()

    func addFoodBasket(qty: Int) -> FoodBasket {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("failed")
            return .init()
        }
        
        let foodBasket = FoodBasket(entity: entity,insertInto: context)
        
        foodBasket.time_log = Date()
        foodBasket.qty = Int32(qty)
        foodBasket.created_at = Date()
        foodBasket.updated_at = Date()
        
        return foodBasket
    }
    
}
