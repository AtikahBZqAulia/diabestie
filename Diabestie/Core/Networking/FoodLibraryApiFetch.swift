//
//  FoodLibraryApiFetch.swift
//  Diabestie
//
//  Created by Julius Cesario on 13/04/21.
//

import Foundation
import CoreData

//Init variable domain string
private let domainUrlString = "https://us-central1-diabestie.cloudfunctions.net/"

//Init model variable from foodLibrary
struct foodLibrary: Codable {
    let name: String?
    let calories: Int?
    let weight: Int?
    let sugar: Int?
}


class CoreDataStack {
    
    private init() {}
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.dataModel)

        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
}

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
    
    func fetchFilms(completion: @escaping(Error?) -> Void) {
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
            
            _ = self.syncFilms(jsonDictionary: jsonDictionary, taskContext: taskContext)
            
            completion(nil)
        }
    }
    
    private func syncFilms(jsonDictionary: [foodLibrary], taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        taskContext.performAndWait {
//            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: FoodLibraries.self.description())
//            let episodeIds = jsonDictionary.map { $0.name }.compactMap { $0 }
//
//            print("ASDASDASD \(episodeIds)")
//            matchingEpisodeRequest.predicate = NSPredicate(format: "food_name in %@", argumentArray: episodeIds)
//
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingEpisodeRequest)
//            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
//            do {
//                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
//                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
//                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs], into: [self.persistentContainer.viewContext])
//                }
//            } catch {
//                print("Error: \(error)\nCould not batch delete existing records.")
//                return
//            }
            
            let episodeIds = jsonDictionary.map { $0.name }.compactMap { $0 }
            let deletedEventsPredicate = NSPredicate(format: "food_name IN %@", episodeIds)
            let deletedEventsRequest: NSFetchRequest<NSFetchRequestResult> = FoodLibraries.fetchRequest()
            deletedEventsRequest.predicate = deletedEventsPredicate
            let batchDeleteEvents = NSBatchDeleteRequest(fetchRequest: deletedEventsRequest)
       
            do {
                // 5. Execute deletions
                try self.viewContext.execute(batchDeleteEvents)
//                try self.importContext.execute(batchDeleteLocations)
                
                // 6. Finish import by calling save() on the import context
                try self.viewContext.save()
            } catch {
                print("Something went wrong: \(error)")
            }
//
            // Create new records.
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
            
            // Save all the changes just made and reset the taskContext to free the cache.
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                taskContext.reset() // Reset the context to clean up the cache and low the memory footprint.
            }
            successfull = true
        }
        return successfull
    }
}


//Init Class Food Manager
final class ApiRepository {
    //function fetch foods from API
    func fetchFoods(completion: @escaping (_ foodLibrary: [foodLibrary]?, _ error: Error?) -> Void) {
        //Init API getFoods from api url
        let url = URL(string: domainUrlString + "getFoods/")!
        //Call API and check if there are error on API
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching foods: \(error)")
                return
            }
            
            //Call API and check if there are error on API
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            //get Data and decode it into foodLibrary Model for data handling
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "dataErrorDomain", code: 101, userInfo: nil)
                completion(nil, error)
                return
            }
            
            do {
//                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonObject = try? JSONDecoder().decode([foodLibrary].self, from: data)

                guard let result = jsonObject else {
                    throw NSError(domain: "dataErrorDomain", code: 100, userInfo: nil)
                }
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }).resume()
        
    }
    
//    let importContext: NSManagedObjectContext
//
//    init(persistentContainer: NSPersistentContainer) {
//        importContext = persistentContainer.newBackgroundContext()
//        importContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//    }
//
//
//    lazy var decoder: JSONDecoder = {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        decoder.userInfo[.managedObjectContext] = importContext
//        return decoder
//    }()
    
    //    func runImport() {
    //        // 1. Build the correct URL
    //
    //        let url = URL(string: domainUrlString + "getFoods/")!
    //
    //        URLSession.shared.dataTaskPublisher(for: url)
    //            .map(\.data)
    //            .sink(receiveCompletion: { completion in
    //                if case .failure(let error) = completion {
    //                    print("something went wrong: \(error)")
    //                }
    //            }, receiveValue: { [weak self] data in
    //                guard let self = self
    //                else { return }
    //
    //                self.importContext.perform {
    //                    do {
    //                        // 2. Decode the response
    ////                        let response = try self.decoder.decode(ImporterResponse.self, from: data)
    //
    //                        let foodData = try? JSONDecoder().decode([foodLibrary].self, from: data)
    //
    //                        // 3. Store the version token
    ////                        self.versionToken = response.versionToken
    //
    //                        // 4. Build batch delete requests
    //                        let deletedEventsPredicate = NSPredicate(format: "id IN %@", response.deleted.events)
    //                        let deletedEventsRequest: NSFetchRequest<Event> = Event.fetchRequest()
    //                        deletedEventsRequest.predicate = deletedEventsPredicate
    //                        let batchDeleteEvents = NSBatchDeleteRequest(fetchRequest: deletedEventsRequest)
    //
    //                        let deletedLocationsPredicate = NSPredicate(format: "id IN %@", response.deleted.locations)
    //                        let deletedLocationsRequest: NSFetchRequest<Location> = Location.fetchRequest()
    //                        deletedLocationsRequest.predicate = deletedLocationsPredicate
    //                        let batchDeleteLocations = NSBatchDeleteRequest(fetchRequest: deletedLocationsRequest)
    //
    //                        do {
    //                            // 5. Execute deletions
    //                            try self.importContext.execute(batchDeleteEvents)
    //                            try self.importContext.execute(batchDeleteLocations)
    //
    //                            // 6. Finish import by calling save() on the import context
    //                            try self.importContext.save()
    //                        } catch {
    //                            print("Something went wrong: \(error)")
    //                        }
    //                    } catch {
    //                        print("Failed to decode json: \(error)")
    //                    }
    //                }
    //
    //            }) // store the returned cancellable in a property on `DataImporter`
    //    }
    
}
//extension CodingUserInfoKey {
//    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
//}
