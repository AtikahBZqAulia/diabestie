//
//  MedicineBasket.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class MedicineBasketRepository {
    
    static let shared = MedicineBasketRepository()
    let entityName = MedicineBasket.self.description()

    func addMedicineBasket(qty: Int, medicineLibrary: MedicineLibrary) -> MedicineBasket {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    
        guard let medicineBasket = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? MedicineBasket else {
            return .init()
        }

        medicineBasket.medicinelibrary = medicineLibrary
        medicineBasket.qty = Int32(qty)
        medicineBasket.created_at = Date()
        medicineBasket.updated_at = Date()
        
        return medicineBasket
    }
    
    func updateMedicineBasket(newQty: Int, basket: MedicineBasket){
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let medicineBasket = basket
        medicineBasket.qty = Int32(newQty)
        medicineBasket.updated_at = Date()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteMedicineBasket(basket: MedicineBasket){
        
        print("entiry name \(entityName)")
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(basket)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}
