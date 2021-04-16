//
//  BloodSugarConstraints.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//

import Foundation
import CoreData

class BloodSugarConstraintsRepository {
    
    static let shared = BloodSugarConstraintsRepository()
    let entityName = BloodSugarConstraints.self.description()

    func addBloodSugarConstraints(am_upper: Int, am_lower: Int, f_upper:Int, f_lower:Int) -> BloodSugarConstraints {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("failed")
            return .init()
        }
        
        let bloodSugarConstraints = BloodSugarConstraints(entity: entity,insertInto: context)
        
        bloodSugarConstraints.am_lower_bound = Int32(am_lower)
        bloodSugarConstraints.am_upper_bound = Int32(am_upper)
        bloodSugarConstraints.f_lower_bound = Int32(f_lower)
        bloodSugarConstraints.f_upper_bound = Int32(f_upper)
        bloodSugarConstraints.active = true
        bloodSugarConstraints.created_at = Date()
        bloodSugarConstraints.updated_at = Date()


        return bloodSugarConstraints
    }
    
    func updateBloodSugarConstraints(am_upper: Int, am_lower: Int, f_upper:Int, f_lower:Int, user: Users?){
        
        guard let user = user else {
            print("user not found")
            return
        }
        
        print("USERS \(user)")

        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        print("USERS \(user.bloodsugarconstraint)")

        if let dataConstraints = user.bloodsugarconstraint {
            //This is when user has constraints already, this function is for updating the value
            let bloodSugarConstraints = dataConstraints
            bloodSugarConstraints.am_lower_bound = Int32(am_lower)
            bloodSugarConstraints.am_upper_bound = Int32(am_upper)
            bloodSugarConstraints.f_lower_bound = Int32(f_lower)
            bloodSugarConstraints.f_upper_bound = Int32(f_upper)
        } else {
            //Create new constraint for user
            let bloodSugarConstraints = addBloodSugarConstraints(am_upper: am_upper, am_lower: am_lower, f_upper: f_upper, f_lower: f_lower)
            user.bloodsugarconstraint = bloodSugarConstraints
        }
        
        print("USERS \(user.bloodsugarconstraint)")

        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
