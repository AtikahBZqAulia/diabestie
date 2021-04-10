//
//  BloodSugarEntry.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class BloodSugarEntryRepository {
    
    static let shared = BloodSugarEntryRepository()
    let entityName = BloodSugarEntries.self.description()
    
    func insertBloodSugarEntry(category: Int, bloodSugar: Int, timeLog: Date){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("failed")
            return
        }
        
        let bloodSugarEntry = BloodSugarEntries(entity: entity,insertInto: context)
        
        bloodSugarEntry.blood_sugar = Int32(bloodSugar)
        bloodSugarEntry.category = Int32(category)
        bloodSugarEntry.time_log = timeLog
        bloodSugarEntry.created_at = Date()
        bloodSugarEntry.updated_at = Date()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllBloodSugarEntry() -> [BloodSugarEntries] {
        
        print("entiry name \(entityName)")
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [BloodSugarEntries]
            
//            for data in item {
//                print("BloodSugar Entry \(data.eat_time)")
//                let baskets = data.BloodSugarbasket?.allObjects as! [BloodSugarBasket]
//                for basketData in baskets {
//                    print("BloodSugar Entry Basket \(basketData.qty)")
//                }
//            }
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    
    func deletBloodSugarEntry(bloodSugarEntry: BloodSugarEntries){
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(bloodSugarEntry)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}
