//
//  DataProvider.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 14/04/21.
//

import Foundation
import CoreData

class DataProvider {
    
    private let persistentContainer: NSPersistentContainer
    private let repository: ApiRepository
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(persistentContainer: NSPersistentContainer, repository: ApiRepository) {
        self.persistentContainer = persistentContainer
        self.repository = repository
    }
    
    func fetchFoodApi(completion: @escaping(Error?) -> Void) {
        repository.fetchFoods { jsonDictionary, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let jsonDictionary = jsonDictionary else {
                let error = NSError(domain: "dataErrorDomain", code: 101, userInfo: nil)
                completion(error)
                return
            }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            taskContext.undoManager = nil
            
            _ = self.syncFoodData(jsonDictionary: jsonDictionary, taskContext: taskContext)
            
            completion(nil)
        }
    }
    
    private func syncFoodData(jsonDictionary: [foodLibrary], taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        taskContext.performAndWait {
                        
            for filmDictionary in jsonDictionary {
                let foodData = FoodLibraryRepository.shared.getFood(foodName: filmDictionary.name ?? "")
                
                if foodData.isEmpty {
                    guard let foodLibrary = NSEntityDescription.insertNewObject(forEntityName: "FoodLibraries", into: taskContext) as? FoodLibraries else {
                        print("Error: Failed to create a new Film object!")
                        return
                    }
                    do {
                        try foodLibrary.update(with: filmDictionary)
                    } catch {
                        print("Error: \(error)\nThe quake object will be deleted.")
                        taskContext.delete(foodLibrary)
                    }
                }
            }
            
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                taskContext.reset()
            }
            successfull = true
        }
        
        return successfull
    }
}
