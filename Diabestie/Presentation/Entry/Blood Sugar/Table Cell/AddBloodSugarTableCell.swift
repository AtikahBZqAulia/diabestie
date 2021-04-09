//
//  AddBloodSugarTableCell.swift
//  Diabestie
//
//  Created by Wuri Dita on 06/04/21.
//

import UIKit

class AddBloodSugarTableCell: UITableViewCell {
    
    @IBOutlet weak var textFieldBloodSugar: UITextField!
    
    static let identifier = "AddBloodSugarTableCell"
    //var delegate: addBloodSugarDelegate = AddBloodSugarDiaryViewController() as addBloodSugarDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldBloodSugar.delegate = self
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
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//
//        if !text.isEmpty{
//            delegate.setSaveButtonStage(true)
//            print ("ada isinya")
//        } else if text.isEmpty {
//            delegate.setSaveButtonStage(false)
//            print ("kosong")
//        }
//        return true
//    }
    
}
