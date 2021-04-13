//
//  FoodLibraries+CoreDataProperties.swift
//  Diabestie
//
//  Created by Revarino Putra on 13/04/21.
//
//

import Foundation
import CoreData


extension FoodLibraries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodLibraries> {
        return NSFetchRequest<FoodLibraries>(entityName: "FoodLibraries")
    }

    @NSManaged public var calories: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var food_name: String?
    @NSManaged public var sugar: Int32
    @NSManaged public var updated_at: Date?
    @NSManaged public var weight: Int32
    @NSManaged public var ofFoodBasket: NSSet?

}

// MARK: Generated accessors for ofFoodBasket
extension FoodLibraries {

    @objc(addOfFoodBasketObject:)
    @NSManaged public func addToOfFoodBasket(_ value: FoodBasket)

    @objc(removeOfFoodBasketObject:)
    @NSManaged public func removeFromOfFoodBasket(_ value: FoodBasket)

    @objc(addOfFoodBasket:)
    @NSManaged public func addToOfFoodBasket(_ values: NSSet)

    @objc(removeOfFoodBasket:)
    @NSManaged public func removeFromOfFoodBasket(_ values: NSSet)

}

extension FoodLibraries : Identifiable {

}
