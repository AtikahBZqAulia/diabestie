//
//  MedicineBasket+CoreDataProperties.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 09/04/21.
//
//

import Foundation
import CoreData


extension MedicineBasket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicineBasket> {
        return NSFetchRequest<MedicineBasket>(entityName: "MedicineBasket")
    }

    @NSManaged public var qty: Int32
    @NSManaged public var created_at: Date?
    @NSManaged public var updated_at: Date?
    @NSManaged public var ofMedicineEntry: MedicineEntries?
    @NSManaged public var medicinelibrary: MedicineLibrary?

}

extension MedicineBasket : Identifiable {

}
