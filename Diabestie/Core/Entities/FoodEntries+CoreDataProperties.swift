//
//  FoodEntries+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//
//

import Foundation
import CoreData


extension FoodEntries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntries> {
        return NSFetchRequest<FoodEntries>(entityName: "FoodEntries")
    }

    @NSManaged public var updated_at: Date?
    @NSManaged public var eat_time: Int32
    @NSManaged public var time_log: Date?
    @NSManaged public var created_at: Date?
    @NSManaged public var foodbasket: NSSet?
    @NSManaged public var ofUser: Users?

}

// MARK: Generated accessors for foodbasket
extension FoodEntries {

    @objc(addFoodbasketObject:)
    @NSManaged public func addToFoodbasket(_ value: FoodBasket)

    @objc(removeFoodbasketObject:)
    @NSManaged public func removeFromFoodbasket(_ value: FoodBasket)

    @objc(addFoodbasket:)
    @NSManaged public func addToFoodbasket(_ values: NSSet)

    @objc(removeFoodbasket:)
    @NSManaged public func removeFromFoodbasket(_ values: NSSet)

}

extension FoodEntries : Identifiable {

}
