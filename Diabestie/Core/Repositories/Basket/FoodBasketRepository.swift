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

    func addFoodBasket(qty: Int, timeLog: Date, foodLibrary: FoodLibraries) -> FoodBasket {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let foodBasket = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? FoodBasket else {
            return .init()
        }
        
        foodBasket.foodlibrary = foodLibrary
        foodBasket.time_log = timeLog
        foodBasket.qty = Int32(qty)
        foodBasket.created_at = Date()
        foodBasket.updated_at = Date()
        
        return foodBasket
    }
    
    func updateFoodBasket(newQty: Int, basket: FoodBasket){
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let foodBasket = basket
        foodBasket.qty = Int32(newQty)
        foodBasket.updated_at = Date()
        
        do{
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFoodBasket(basket: FoodBasket){
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(basket)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getFoodEntryTotalNutrition(entry: [FoodBasket]) -> (sugar: Int, calorie:Int){
            
            var totalSugar = 0
            var totalCalorie = 0
            
            
            entry.forEach({ (basket) in
                
                totalSugar += Int(basket.foodlibrary?.sugar ?? 0) * Int(basket.qty)
                totalCalorie += Int(basket.foodlibrary?.calories ?? 0) * Int(basket.qty)
            })
            
            return (totalSugar, totalCalorie)
    }
    
    func getAllFoodBasket() -> [FoodBasket] {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [FoodBasket]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
}
