//
//  MedicineTableCellItem.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 12/04/21.
//

import Foundation
import UIKit

class MedicineTableCellItem: UICollectionViewCell {
    
    static let identifier = "MedicineTableCellItem"
    
    @IBOutlet weak var viewDivider: UIView!
    @IBOutlet weak var lblIntakeCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    
    var isHistory: Bool = false
    
    var medicineEntries: [MedicineEntries]?
    
    var medicineItem: MedicineLibrary? {
        didSet {
            bindViewModel()
        }
    }
    
    var medicineBasket: MedicineBasket? {
        didSet {
            bindViewModelforHistory()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    private func bindViewModelforHistory() {
        
        if let data = medicineBasket {
            let qty = Int(data.qty)
            lblTitle.text = data.medicinelibrary?.medicine_name
            
            lblIntakeCount.text = "\(qty)"
            if qty == 1 {
                lblUnit.text = "pill"
            } else {
                lblUnit.text  = "pills"
            }
        }
        
    }
    
    private func bindViewModel() {
        
        if let data = medicineItem {
            let consumption = data.consumption
            lblTitle.text = data.medicine_name
            
            if consumption == 1 {
                lblUnit.text  = "time"
            } else {
                lblUnit.text  = "times"
            }
            
            var times = 0
            if let entries = medicineEntries {
                for entry in entries {
                    for basket in entry.medicinebasket! {
                        let item = basket as! MedicineBasket
                        if item.medicinelibrary!.medicine_name! == medicineItem!.medicine_name! {
                            times += 1
                            break
                        }
                    }
                }
            }
            
            lblIntakeCount.text = "\(times)/\(consumption)"
        
        }
    }
    
}
