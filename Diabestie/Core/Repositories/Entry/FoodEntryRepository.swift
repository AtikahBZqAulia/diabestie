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
    
    func insertFoodEntry(eatTime: Int, timeLog: Date, foodBasket: NSMutableSet){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FoodEntries", in: context) else {
            print("failed")
            return
        }
        
        let foodEntry = FoodEntries(entity: entity,insertInto: context)
        
        foodEntry.eat_time = Int32(eatTime)
        foodEntry.time_log = timeLog
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
    
    func getFoodEntryNutrition(entry: FoodEntries?) -> (sugar: Int, calorie:Int){
        
        if let data = entry {
            
            var totalSugar = 0
            var totalCalorie = 0
            
            data.foodbasket?.forEach({ (basket) in
                let basketData = basket as! FoodBasket
                totalSugar += Int(basketData.foodlibrary?.sugar ?? 0)
                totalCalorie += Int(basketData.foodlibrary?.calories ?? 0)
            })
            
            return (totalSugar, totalCalorie)
            
        }
        
        return (0,0)
    }
    
    func getFoodEntryTotalNutrition(entry: FoodEntries?) -> (sugar: Int, calorie:Int){
        
        if let data = entry {
            
            var totalSugar = 0
            var totalCalorie = 0
            
            
            data.foodbasket?.forEach({ (basket) in
                let basketData = basket as! FoodBasket
                
                totalSugar += Int(basketData.foodlibrary?.sugar ?? 0) * Int(basketData.qty)
                totalCalorie += Int(basketData.foodlibrary?.calories ?? 0) * Int(basketData.qty)
                totalSugar += Int(basketData.foodlibrary?.sugar ?? 0)
                totalCalorie += Int(basketData.foodlibrary?.calories ?? 0)
            })
            
            return (totalSugar, totalCalorie)
            
        }
        
        return (0,0)
    }

    
    func getFoodEntryTotalNutrition(date: Date) -> (sugar: Int, calorie:Int){
        
        let data = getFoodEntryByDate(date: date)
        
        for data in data {
            var totalSugar = 0
            var totalCalorie = 0
            
            data.foodbasket?.forEach({ (basket) in
                let basketData = basket as! FoodBasket
                
                totalSugar += Int(basketData.foodlibrary?.sugar ?? 0) * Int(basketData.qty)
                totalCalorie += Int(basketData.foodlibrary?.calories ?? 0) * Int(basketData.qty)
            })
            
            return (totalSugar, totalCalorie)
        }
        
        return (0,0)
        
    }
}
