//
//  UserRepository.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 08/04/21.
//

import Foundation
import CoreData

class UserRepository {
    
    static let shared = UserRepository()
    let entityName = Users.self.description()

    func insertUser(email: String,
                    firstName: String,
                    lastName: String,
                    password: String){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("failed")
            return
        }
      
        let user = Users(entity: entity,insertInto: context)
        
        user.email = email
        user.first_name = firstName
        user.last_name = lastName
        user.password = password
        user.created_at = Date()
        user.updated_at = Date()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getUserByEmail(email: String) -> [Users] {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        //Check if user is exists
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            
            let item = try context.fetch(fetchRequest)
            
            return item as! [Users]
            
        } catch {
            print("\(error)")
        }
        
        return []
    }
    
    func deleteUser(user: Users) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        do {
            context.delete(user)
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insertBloogSugarConstraint(am_upper: Int, am_lower: Int, f_upper:Int, f_lower:Int) {
//
//        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
//
//        let bloodSugarConstraint = BloodSugarConstraintsRepository.shared.addBloodSugarConstraints(am_upper: am_upper, am_lower: am_lower, f_upper: f_upper, f_lower: f_lower)
        let user = self.getUserByEmail(email: Constants.globalUserEmail).last
        
        BloodSugarConstraintsRepository.shared.updateBloodSugarConstraints(am_upper: am_upper, am_lower: am_lower, f_upper: f_upper, f_lower: f_lower, user: user)
        
//        if user?.bloodsugarconstraint == nil {
//            user?.bloodsugarconstraint = bloodSugarConstraint
//        } else {
//            user?.bloodsugarconstraint?.am_upper_bound = Int32(am_upper)
//            user?.bloodsugarconstraint?.am_lower_bound = Int32(am_lower)
//            user?.bloodsugarconstraint?.f_upper_bound = Int32(f_upper)
//            user?.bloodsugarconstraint?.f_lower_bound = Int32(f_lower)
//        }
//
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
    }
    
}
