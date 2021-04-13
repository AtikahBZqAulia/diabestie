//
//  MedicineLibraryEntry.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class MedicineLibraryRepository {
    
    static let shared = MedicineLibraryRepository()
    let entityName = MedicineLibrary.self.description()
    
    func insertMedicineLibrary(name: String,
                               consumption: Int){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("failed")
            return
        }
        
        let medicineLibrary = MedicineLibrary(entity: entity,insertInto: context)
        
        medicineLibrary.medicine_name = name
        medicineLibrary.consumption = Int32(consumption)
        medicineLibrary.created_at = Date()
        medicineLibrary.updated_at = Date()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllMedicineLibrary() -> [MedicineLibrary] {
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [MedicineLibrary]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    func deleteMedicineLibrary(medicineLibrary: MedicineLibrary) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(medicineLibrary)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getMedicine(medicineName: String) -> [MedicineLibrary] {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "medicine_name == %@", medicineName)
        do {
            let item = try context.fetch(fetchRequest)
            return item as! [MedicineLibrary]
        }catch {
            print(error)
        }
        return []
    }
    
}
