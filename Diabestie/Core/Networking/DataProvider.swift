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
            
            let episodeIds = jsonDictionary.map { $0.name }.compactMap { $0 }
            let deletedEventsPredicate = NSPredicate(format: "food_name IN %@", episodeIds)
            let deletedEventsRequest: NSFetchRequest<NSFetchRequestResult> = FoodLibraries.fetchRequest()
            deletedEventsRequest.predicate = deletedEventsPredicate
            let batchDeleteEvents = NSBatchDeleteRequest(fetchRequest: deletedEventsRequest)
       
            do {
                try self.viewContext.execute(batchDeleteEvents)
            } catch {
                print("Something went wrong: \(error)")
            }

            for filmDictionary in jsonDictionary {
                
                guard let film = NSEntityDescription.insertNewObject(forEntityName: "FoodLibraries", into: taskContext) as? FoodLibraries else {
                    print("Error: Failed to create a new Film object!")
                    return
                }
                
                do {
                    try film.update(with: filmDictionary)
                } catch {
                    print("Error: \(error)\nThe quake object will be deleted.")
                    taskContext.delete(film)
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
