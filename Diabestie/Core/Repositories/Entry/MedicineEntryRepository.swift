//
//  MedicineEntryRepository.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class MedicineEntryRepository {
    
    static let shared = MedicineEntryRepository()
    let entityName = MedicineEntries.self.description()
    
    func insertMedicineEntry(category: Int, medicineBasket: NSMutableSet){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("failed")
            return
        }
        
        let MedicineEntry = MedicineEntries(entity: entity,insertInto: context)
        
        MedicineEntry.category = Int32(category)
        MedicineEntry.time_log = Date()
        MedicineEntry.created_at = Date()
        MedicineEntry.updated_at = Date()
        
        MedicineEntry.medicinebasket = medicineBasket
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllMedicineEntry() -> [MedicineEntries] {
        
        print("entiry name \(entityName)")
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [MedicineEntries]
            
//            for data in item {
//                print("Medicine Entry \(data.eat_time)")
//                let baskets = data.Medicinebasket?.allObjects as! [MedicineBasket]
//                for basketData in baskets {
//                    print("Medicine Entry Basket \(basketData.qty)")
//                }
//            }
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    func deleteMedicineEntry(medicineEntry: MedicineEntries){
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(medicineEntry)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
}