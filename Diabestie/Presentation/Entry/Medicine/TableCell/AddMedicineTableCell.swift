//
//  AddMedicineTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 07/04/21.
//

import UIKit

class AddMedicineTableCell: UITableViewCell {

    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var medicineTimes: UILabel!
    @IBOutlet weak var stepperValue: UILabel!
    @IBOutlet weak var stepperView: DesignableView!
    @IBOutlet weak var addButtonView: DesignableView!
    
    static let identifier = "medicineList"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepperView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func increment(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            stepperValue.text = "\(value + 1)"
        }
    }
    @IBAction func decrement(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            if value - 1 <= 0 {
                addButtonView.isHidden = false
                stepperView.isHidden = true
            }
            else {
                stepperValue.text = "\(value - 1)"
            }
        }
    }
    
    @IBAction func addMedicine(_ sender: UIButton) {
        addButtonView.isHidden = true
        stepperView.isHidden = false
    }
}
