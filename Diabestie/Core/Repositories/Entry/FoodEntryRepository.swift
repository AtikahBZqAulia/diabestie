//
//  FoodEntryRepository.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class FoodEntryRepository {
    
    static let shared = FoodEntryRepository()
    let entityName = FoodEntries.self.description()
    
    func addFoodEntry(eatTime: Int, foodBasket: NSMutableSet){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FoodEntries", in: context) else {
            print("failed")
            return
        }
        
        let foodEntry = FoodEntries(entity: entity,insertInto: context)
        
        foodEntry.eat_time = Int32(eatTime)
        foodEntry.time_log = Date()
        foodEntry.created_at = Date()
        foodEntry.updated_at = Date()
        
        foodEntry.foodbasket = foodBasket
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFoodEntry(foodEntry: FoodEntries){
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(foodEntry)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getAllFoodEntry() -> [FoodEntries] {
        
        print("entiry name \(entityName)")
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FoodEntries")
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [FoodEntries]
            
//            for data in item {
//                print("Food Entry \(data.eat_time)")
//                let baskets = data.foodbasket?.allObjects as! [FoodBasket]
//                for basketData in baskets {
//                    print("Food Entry Basket \(basketData.qty)")
//                }
//            }
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
}
