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
    static var isFilled: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bloodSugarTextField.delegate = self
        bloodSugarTextField.placeholder = "Add"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension AddBloodSugarTableCell: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bloodSugarTextField.resignFirstResponder()
    }
    
}
