//
//  Users+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
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
    @NSManaged public var bloodsugarentry: NSSet?
    @NSManaged public var medicineentry: NSSet?
    @NSManaged public var foodentry: NSSet?

}

// MARK: Generated accessors for bloodsugarentry
extension Users {

    @objc(addBloodsugarentryObject:)
    @NSManaged public func addToBloodsugarentry(_ value: BloodSugarEntries)

    @objc(removeBloodsugarentryObject:)
    @NSManaged public func removeFromBloodsugarentry(_ value: BloodSugarEntries)

    @objc(addBloodsugarentry:)
    @NSManaged public func addToBloodsugarentry(_ values: NSSet)

    @objc(removeBloodsugarentry:)
    @NSManaged public func removeFromBloodsugarentry(_ values: NSSet)

}

// MARK: Generated accessors for medicineentry
extension Users {

    @objc(addMedicineentryObject:)
    @NSManaged public func addToMedicineentry(_ value: MedicineEntries)

    @objc(removeMedicineentryObject:)
    @NSManaged public func removeFromMedicineentry(_ value: MedicineEntries)

    @objc(addMedicineentry:)
    @NSManaged public func addToMedicineentry(_ values: NSSet)

    @objc(removeMedicineentry:)
    @NSManaged public func removeFromMedicineentry(_ values: NSSet)

}

// MARK: Generated accessors for foodentry
extension Users {

    @objc(addFoodentryObject:)
    @NSManaged public func addToFoodentry(_ value: BloodSugarEntries)

    @objc(removeFoodentryObject:)
    @NSManaged public func removeFromFoodentry(_ value: BloodSugarEntries)

    @objc(addFoodentry:)
    @NSManaged public func addToFoodentry(_ values: NSSet)

    @objc(removeFoodentry:)
    @NSManaged public func removeFromFoodentry(_ values: NSSet)

}

extension Users : Identifiable {

}
