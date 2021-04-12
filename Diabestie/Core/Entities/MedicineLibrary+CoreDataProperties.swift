//
//  MedicineLibrary+CoreDataProperties.swift
//  Diabestie
//
//  Created by Revarino Putra on 13/04/21.
//
//

import Foundation
import CoreData


extension MedicineLibrary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicineLibrary> {
        return NSFetchRequest<MedicineLibrary>(entityName: "MedicineLibrary")
    }

    @NSManaged public var consumption: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var medicine_name: String?
    @NSManaged public var updated_at: Date?
    @NSManaged public var ofMedicineBasket: NSSet?

}

// MARK: Generated accessors for ofMedicineBasket
extension MedicineLibrary {

    @objc(addOfMedicineBasketObject:)
    @NSManaged public func addToOfMedicineBasket(_ value: MedicineBasket)

    @objc(removeOfMedicineBasketObject:)
    @NSManaged public func removeFromOfMedicineBasket(_ value: MedicineBasket)

    @objc(addOfMedicineBasket:)
    @NSManaged public func addToOfMedicineBasket(_ values: NSSet)

    @objc(removeOfMedicineBasket:)
    @NSManaged public func removeFromOfMedicineBasket(_ values: NSSet)

}

extension MedicineLibrary : Identifiable {

}
