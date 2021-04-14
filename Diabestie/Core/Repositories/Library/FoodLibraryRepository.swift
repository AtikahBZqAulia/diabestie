//
//  FoodLibraryEntry.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData


class FoodLibraryRepository {
    
    static let shared = FoodLibraryRepository()
    let entityName = FoodLibraries.self.description()
    
    
    func insertFoodLibrary(name: String,
                               calories: Int,
                               weight: Int,
                               sugar: Int){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("failed")
            return
        }
        
        let foodLibrary = FoodLibraries(entity: entity,insertInto: context)
        
        foodLibrary.food_name = name
        foodLibrary.weight = Int32(weight)
        foodLibrary.calories = Int32(calories)
        foodLibrary.sugar = Int32(sugar)
        foodLibrary.created_at = Date()
        foodLibrary.updated_at = Date()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func reseFoodLibrary(){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "ofFoodBasket != NULL")

        do {
            
            let item = try context.fetch(fetchRequest) as! [FoodLibraries]
            
            item.forEach { (data) in
                data.ofFoodBasket = nil
            }
            
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func getAllFoodLibrary() -> [FoodLibraries] {
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [FoodLibraries]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    func deleteFoodLibrary(foodLibrary: FoodLibraries) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(foodLibrary)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getFood(foodName: String) -> [FoodLibraries] {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "food_name == %@", foodName)
        do {
            let item = try context.fetch(fetchRequest)
            return item as! [FoodLibraries]
        } catch {
            print (error)
        }
        return []
    }
}
