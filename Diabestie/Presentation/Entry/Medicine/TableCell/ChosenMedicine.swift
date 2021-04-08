//
//  ChosenMedicine.swift
//  Diabestie
//
//  Created by Revarino Putra on 06/04/21.
//

import UIKit

class ChosenMedicine: UITableViewCell {
    
    @IBOutlet weak var stepperValue: UILabel!
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var medicineTimes: UILabel!
    
    static let identifier = "medicineList"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func decrement(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            stepperValue.text = "\(value - 1)"
        }
    }
    
    @IBAction func increment(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            stepperValue.text = "\(value + 1)"
        }
    }
}
