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
    
    static func todaySugarLevelData() -> (range: String, indicator: Constants.BloodSugarLevelIndicatorCode) {
        
        let date = Date()
        let user = UserRepository.shared.getUserByEmail(email: Constants.globalUserEmail).last
        let latestBloodSugarEntry = shared.getBloodSugarEntryByDate(date: date).last
        let todayBloodSugarMax = shared.getBloodSugarEntryByDate(date: date).map {$0.blood_sugar}.max() ?? 0
        let todayBloodSugarMin = shared.getBloodSugarEntryByDate(date: date).map {$0.blood_sugar}.min() ?? 0

        let bloodSugarRange = "\(todayBloodSugarMin) - \(todayBloodSugarMax)"

        if latestBloodSugarEntry?.category == 1 {
            // This is for fasting reference
            let lowerBound = user?.bloodsugarconstraint?.f_lower_bound ?? 0
            let higherBound = user?.bloodsugarconstraint?.f_upper_bound ?? 0
            
            // Check wether blood sugar level indicator is low/high/stable
            if lowerBound == 0 || higherBound == 0  {
                return (bloodSugarRange ,.none)
            } else if latestBloodSugarEntry?.blood_sugar ?? 0 > lowerBound && latestBloodSugarEntry?.blood_sugar ?? 0 < higherBound{
                return (bloodSugarRange ,.stable)
            } else if latestBloodSugarEntry?.blood_sugar ?? 0 > higherBound {
                return (bloodSugarRange ,.high)
            } else if latestBloodSugarEntry?.blood_sugar ?? 0 < lowerBound {
                return (bloodSugarRange ,.low)
            }
            
        } else {
            // This is for meal reference
            let lowerBound = user?.bloodsugarconstraint?.am_lower_bound ?? 0
            let higherBound = user?.bloodsugarconstraint?.am_upper_bound ?? 0
            
            
            // Check wether blood sugar level indicator is low/high/stable
            if lowerBound == 0 || higherBound == 0  {
                return (bloodSugarRange ,.none)
            } else if latestBloodSugarEntry?.blood_sugar ?? 0 > lowerBound && latestBloodSugarEntry?.blood_sugar ?? 0 < higherBound{
                return (bloodSugarRange ,.stable)
            } else if latestBloodSugarEntry?.blood_sugar ?? 0 > higherBound {
                return (bloodSugarRange ,.high)
            } else if latestBloodSugarEntry?.blood_sugar ?? 0 < lowerBound {
                return (bloodSugarRange ,.low)
            }
        }
        
        return ("" ,.none)

    }
    
}
