//
//  Users+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 08/04/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var created_at: Date?
    @NSManaged public var email: String?
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var password: String?
    @NSManaged public var updated_at: Date?
    @NSManaged public var bloodsugarconstraint: BloodSugarConstraints?

}

extension Users : Identifiable {

}
