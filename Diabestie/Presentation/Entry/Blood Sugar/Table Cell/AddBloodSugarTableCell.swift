//
//  AddBloodSugarTableCell.swift
//  Diabestie
//
//  Created by Wuri Dita on 06/04/21.
//

import UIKit

class AddBloodSugarTableCell: UITableViewCell {
    
    @IBOutlet weak var bloodSugarTextField: UITextField!
    
    static let identifier = "AddBloodSugarTableCell"
    
    weak var delegate: AddBloodSugarDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        bloodSugarTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension AddBloodSugarTableCell: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bloodSugarTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            print ("ada isinya")
            delegate?.onBloodSugarLevel(bloodSugarLevel: Int(text) ?? 0)
        } else if text.isEmpty {
            delegate?.onBloodSugarLevel(bloodSugarLevel: 0)
        }
        
        return true
    }
    
}
