//
//  CoreDataManager.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 08/04/21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let sharedManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Constants.dataModel)
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func preloadData(){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        //Check if user is exists
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "email == %@", Constants.globalUserEmail)
        
        do {
            
            let item = try context.fetch(fetchRequest)
            
            if item.isEmpty {
                print("User is not exist, creating a new one")
                
                UserRepository.shared.insertUser(
                    email: Constants.globalUserEmail,
                    firstName: Constants.globalUserFirstName,
                    lastName: Constants.globalUserLastName,
                    password: Constants.globalUserPasword
                )
                
            } else {
                print("User already exists")
            }
            
        } catch {
            print("\(error)")
        }
        
        saveContext()
    }
    
    func preloadFoodLibraryData(){
//        let baskets = NSMutableSet.init()
//
//        for _ in 1..<4 {
//            let value = (arc4random() % 90) + 100
//            let foodBasket = FoodBasketRepository.shared.addFoodBasket(qty: Int(value))
//            baskets.add(foodBasket)
//        }
//       FoodEntryRepository.shared.addFoodEntry(eatTime: 1, foodBasket: baskets)
//       FoodEntryRepository.shared.getAllFoodEntry()
    }
    
    func preloadMedicineLibraryData(){
        
    }
    
    func deleteAllData(){
        
        let storeCoordinator = persistentContainer.persistentStoreCoordinator
        let storeDescription = persistentContainer.persistentStoreDescriptions[0]
        guard let storeURL = storeDescription.url else {
            return
        }
                
        do {
            try storeCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        }
        catch {
            return
        }
        
        storeCoordinator.addPersistentStore(with: storeDescription) {
            (persistentStoreCoordinator, error) in
            
            if let error = error {
                print("\(error)")
            }
        }
    }
    
}

