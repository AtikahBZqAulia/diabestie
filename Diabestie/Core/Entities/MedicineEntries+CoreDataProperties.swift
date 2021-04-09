//
//  MedicineEntries+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//
//

import Foundation
import CoreData


extension MedicineEntries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicineEntries> {
        return NSFetchRequest<MedicineEntries>(entityName: "MedicineEntries")
    }

    @NSManaged public var category: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var time_log: Date?
    @NSManaged public var updated_at: Date?
    @NSManaged public var medicinebasket: NSSet?
    @NSManaged public var ofUser: Users?

}

// MARK: Generated accessors for medicinebasket
extension MedicineEntries {

    @objc(addMedicinebasketObject:)
    @NSManaged public func addToMedicinebasket(_ value: MedicineBasket)

    @objc(removeMedicinebasketObject:)
    @NSManaged public func removeFromMedicinebasket(_ value: MedicineBasket)

    @objc(addMedicinebasket:)
    @NSManaged public func addToMedicinebasket(_ values: NSSet)

    @objc(removeMedicinebasket:)
    @NSManaged public func removeFromMedicinebasket(_ values: NSSet)

}

extension MedicineEntries : Identifiable {

}
