//
//  BloodSugarConstraints+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//
//

import Foundation
import CoreData


extension BloodSugarConstraints {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BloodSugarConstraints> {
        return NSFetchRequest<BloodSugarConstraints>(entityName: "BloodSugarConstraints")
    }

    @NSManaged public var active: Bool
    @NSManaged public var am_lower_bound: Int32
    @NSManaged public var am_upper_bound: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var f_lower_bound: Int32
    @NSManaged public var f_upper_bound: Int32
    @NSManaged public var updated_at: Date?
    @NSManaged public var ofUser: Users?

}

extension BloodSugarConstraints : Identifiable {

}
