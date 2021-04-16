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
    
    weak var delegate: CreateMedicineDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        medicineNameTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension InputMedicineNameTableCell: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        medicineNameTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            delegate?.medicineName(name: text)
        }
        else if text.isEmpty {
            delegate?.medicineName(name: "")
        }
        
        return true
    }
}
