//
//  FoodBasket+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 10/04/21.
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
    @NSManaged public var ofFoodEntry: FoodEntries?
    @NSManaged public var foodlibrary: FoodLibraries?

}

extension FoodBasket : Identifiable {

}
