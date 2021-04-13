//
//  FoodBasket+CoreDataProperties.swift
//  Diabestie
//
//  Created by Revarino Putra on 13/04/21.
//
//

import Foundation
import CoreData


extension FoodBasket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodBasket> {
        return NSFetchRequest<FoodBasket>(entityName: "FoodBasket")
    }

    @NSManaged public var created_at: Date?
    @NSManaged public var qty: Int32
    @NSManaged public var time_log: Date?
    @NSManaged public var updated_at: Date?
    @NSManaged public var foodlibrary: FoodLibraries?
    @NSManaged public var ofFoodEntry: FoodEntries?

}

extension FoodBasket : Identifiable {

}
