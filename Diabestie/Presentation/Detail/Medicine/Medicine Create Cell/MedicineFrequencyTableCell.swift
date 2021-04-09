//
//  MedicineFrequencyTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 08/04/21.
//

import UIKit

class MedicineFrequencyTableCell: UITableViewCell {

    @IBOutlet weak var stepperValue: UILabel!
    static let identifier = "MedicineFrequencyCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func decrement(_ sender: UIButton) {
        if var value = Int(stepperValue.text ?? "1"){
            if value - 1 <= 0 {
                value = 1
            }
            else {
                value -= 1
            }
            stepperValue.text = "\(value)"
        }
    }
    @IBAction func increment(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            stepperValue.text = "\(value + 1)"
        }
    }
}
