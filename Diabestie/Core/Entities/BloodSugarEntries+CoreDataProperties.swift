//
//  BloodSugarEntries+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//
//

import Foundation
import CoreData


extension BloodSugarEntries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BloodSugarEntries> {
        return NSFetchRequest<BloodSugarEntries>(entityName: "BloodSugarEntries")
    }

    @NSManaged public var category: Int32
    @NSManaged public var time_log: Date?
    @NSManaged public var blood_sugar: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var updated_at: Date?
    @NSManaged public var ofUser: Users?

}

extension BloodSugarEntries : Identifiable {

}
