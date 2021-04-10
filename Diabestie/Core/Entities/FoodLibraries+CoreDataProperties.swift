//
//  FoodLibraries+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 10/04/21.
//
//

import Foundation
import CoreData


extension FoodLibraries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodLibraries> {
        return NSFetchRequest<FoodLibraries>(entityName: "FoodLibraries")
    }

    @NSManaged public var weight: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var food_name: String?
    @NSManaged public var updated_at: Date?
    @NSManaged public var sugar: Int32
    @NSManaged public var calories: Int32
    @NSManaged public var ofFoodBasket: FoodBasket?

}

extension FoodLibraries : Identifiable {

}
