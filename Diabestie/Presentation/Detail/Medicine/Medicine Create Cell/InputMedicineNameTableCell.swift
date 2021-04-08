//
//  InputMedicineNameTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 08/04/21.
//

import UIKit

class InputMedicineNameTableCell: UITableViewCell {
    
    @IBOutlet weak var medicineNameTextField: UITextField!
    static let identifier = "MedicineNameCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
