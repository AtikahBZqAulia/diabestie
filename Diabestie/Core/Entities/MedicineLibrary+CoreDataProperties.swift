//
//  MedicineLibrary+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//
//

import Foundation
import CoreData


extension MedicineLibrary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicineLibrary> {
        return NSFetchRequest<MedicineLibrary>(entityName: "MedicineLibrary")
    }

    @NSManaged public var medicine_name: String?
    @NSManaged public var consumption: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var updated_at: Date?
    @NSManaged public var ofMedicineBasket: MedicineBasket?

}

extension MedicineLibrary : Identifiable {

}
