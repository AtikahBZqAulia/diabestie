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
    
    func insertFoodEntry(eatTime: Int, foodBasket: NSMutableSet){
        
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
    
    func getFoodEntryByDate(date: Date) -> [FoodEntries] {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "time_log >= %@ && time_log <= %@ ", date.startOfDay as CVarArg, date.endOfDay as CVarArg)

        do {
            
            let item = try context.fetch(fetchRequest) as! [FoodEntries]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    func getAllFoodEntry() -> [FoodEntries] {
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FoodEntries")
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [FoodEntries]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
}
