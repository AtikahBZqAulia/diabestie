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

    @NSManaged public var consumption: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var medicine_name: String?
    @NSManaged public var updated_at: Date?
    @NSManaged public var ofFoodBasket: FoodBasket?

}

extension FoodLibraries : Identifiable {

}
