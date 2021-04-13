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
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblIntakeCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var medicineBasket: MedicineBasket? {
        didSet {
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    private func bindViewModel() {
        if let data = medicineBasket {
            lblTitle.text = data.medicinelibrary?.medicine_name
            lblIntakeCount.text = "\(Int(data.qty))"
        }
    }
    
}
