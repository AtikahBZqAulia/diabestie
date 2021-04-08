//
//  AddBloodSugarTableCell.swift
//  Diabestie
//
//  Created by Wuri Dita on 06/04/21.
//

import UIKit

class AddBloodSugarTableCell: UITableViewCell {
    
    static let identifier = "AddBloodSugarTableCell"
    
    @IBOutlet weak var textFieldBloodSugar: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFieldBloodSugar.placeholder = "Add"
        textFieldBloodSugar.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension AddBloodSugarTableCell: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldBloodSugar.resignFirstResponder()
    }
    
}
