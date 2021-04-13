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
        
        let userData = UserRepository.shared.getCurrentUser()
                
        //Check if user is not exists yet
        if userData == nil {
            UserRepository.shared.insertUser(
                email: Constants.globalUserEmail,
                firstName: Constants.globalUserFirstName,
                lastName: Constants.globalUserLastName,
                password: Constants.globalUserPasword
            )
        }
        
        preloadFoodLibraryFromAPI()
        preloadMedicineLibraryData()
    }
    
    func preloadFoodLibraryData(){
        //Check if food library preload data is exists
        if FoodLibraryRepository.shared.getAllFoodLibrary().isEmpty {
            FoodLibraryRepository.shared.insertFoodLibrary(name: "Banana", calories: 100, weight: 1, sugar: 100)
            FoodLibraryRepository.shared.insertFoodLibrary(name: "Ananab", calories: 100, weight: 1, sugar: 100)
            FoodLibraryRepository.shared.insertFoodLibrary(name: "Chocolate", calories: 100, weight: 1, sugar: 100)
        }
        
    }
    
    func preloadFoodLibraryFromAPI(){
        //Fetch data from API on NEtworking/FoodLibraryAPIFetch
        FoodManager().fetchFoods { (foodLibraries) in
            foodLibraries.forEach { (data) in
                FoodLibraryRepository.shared.insertFoodLibrary(name: data.name ?? "", calories: data.calories ?? 0, weight: data.weight ?? 0, sugar: data.sugar ?? 0)
            }
        }
    }
    
    func preloadMedicineLibraryData(){
        //Check if medicine library preload data is exists
        if MedicineLibraryRepository.shared.getAllMedicineLibrary().isEmpty {
            MedicineLibraryRepository.shared.insertMedicineLibrary(name: "Paracetamol", consumption: 3)
            MedicineLibraryRepository.shared.insertMedicineLibrary(name: "Glumetza", consumption: 3)
        }
    }
        
    func preloadEntries(){
      
        
        preloadMedicineEntriesData()
        preloadFoodEntriesData()
    }
    
    func preloadMedicineEntriesData() {
        let lib = MedicineLibraryRepository.shared.getAllMedicineLibrary()[0]
        let basket = MedicineBasketRepository.shared.addMedicineBasket(qty: 3, medicineLibrary: lib)
        let baskets = NSMutableSet.init()
        baskets.add(basket)
        MedicineEntryRepository.shared.insertMedicineEntry(category: 2, medicineBasket: baskets, time: Date())
    }
    
    func preloadFoodEntriesData() {
        
        if FoodEntryRepository.shared.getAllFoodEntry().isEmpty {
            let foodBasket = NSMutableSet.init()
                
            for _ in 1..<4 {
                let foodLibrary = FoodLibraryRepository.shared.getAllFoodLibrary()[0]
                let basket = FoodBasketRepository.shared.addFoodBasket(qty: 2, foodLibrary: foodLibrary)
                foodBasket.add(basket)
            }
                FoodEntryRepository.shared.insertFoodEntry(eatTime: 3, foodBasket: foodBasket)
        }
        
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
        
        //Reload the data again
        preloadData()
    }
    
}

