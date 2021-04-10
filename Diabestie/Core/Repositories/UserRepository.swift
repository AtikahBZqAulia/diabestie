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
    
}
