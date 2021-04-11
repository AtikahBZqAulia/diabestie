//
//  BloodSugarEntry.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData
import UIKit

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
    
    func getBloodSugarEntryByDate(date: Date) -> [BloodSugarEntries] {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "time_log >= %@ && time_log <= %@ ", date.startOfDay as CVarArg, date.endOfDay as CVarArg)

        do {
            
            let item = try context.fetch(fetchRequest) as! [BloodSugarEntries]
            
            return item
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    func getAllBloodSugarEntry() -> [BloodSugarEntries] {
                
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            
            let item = try context.fetch(fetchRequest) as! [BloodSugarEntries]
            
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
    
    static func sugarLevelRange(date: Date = Date()) -> String {
        
        let todayBloodSugarMax = shared.getBloodSugarEntryByDate(date: date).map {$0.blood_sugar}.max() ?? 0
        let todayBloodSugarMin = shared.getBloodSugarEntryByDate(date: date).map {$0.blood_sugar}.min() ?? 0

        let bloodSugarRange = "\(todayBloodSugarMin) - \(todayBloodSugarMax)"
        
        return bloodSugarRange

    }
    
    func sugarLevelIndicator(bloodSugarEntry: BloodSugarEntries?) -> Constants.BloodSugarLevelIndicatorCode {
        
        let category = bloodSugarEntry?.category ?? 0
        let bloodSugar = bloodSugarEntry?.blood_sugar ?? 0
        let bloodSugarConstraint = UserRepository.shared.getCurrentUser()?.bloodsugarconstraint
        
        if let data = bloodSugarConstraint {
            if category == 1 {
                // This is for fasting reference
                let lowerBound = data.f_lower_bound
                let higherBound = data.f_upper_bound
                
                // Check wether blood sugar level indicator is low/high/stable
                if bloodSugar > lowerBound && bloodSugar < higherBound{
                    return .stable
                } else if  bloodSugar > higherBound {
                    return .high
                } else if bloodSugar < lowerBound {
                    return .low
                }
                
            } else {
                // This is for meal reference
                let lowerBound = data.am_lower_bound
                let higherBound = data.am_upper_bound
                
                // Check wether blood sugar level indicator is low/high/stable
                if bloodSugar > lowerBound && bloodSugar < higherBound{
                    return .stable
                } else if bloodSugar > higherBound {
                    return .high
                } else if bloodSugar < lowerBound {
                    return .low
                }
            }
        }
        
        return .none
    }
    
}
