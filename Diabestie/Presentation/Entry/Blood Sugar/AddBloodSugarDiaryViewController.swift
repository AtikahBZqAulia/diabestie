//
//  AddBloodSugarDiaryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class AddBloodSugarDiaryViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var bloodSugarIsFilled: Bool = false
    var bloodSugarCategoryIsFilled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false

    }
    
    @IBAction func backToPreviousPage(_ sender: UIBarButtonItem) {
        self.popBack(2)
    }

}

extension AddBloodSugarDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableViewIdentifier() -> [String] {
        var identifiers = [String]()
        
        identifiers.append(AddBloodSugarCategoryTableCell.identifier)
        identifiers.append(AddBloodSugarTableCell.identifier)
        
        return identifiers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewIdentifier().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = self.tableViewIdentifier()[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        
        switch identifier {
        case AddBloodSugarCategoryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddBloodSugarCategoryTableCell else {
                return UITableViewCell()
            }
            cell.bloodSugarCategoryTextField.tag = indexPath.row //0
            cell.bloodSugarCategoryTextField.delegate = self
            return cell
            
        case AddBloodSugarTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddBloodSugarTableCell else {
                return UITableViewCell()
            }
            addSeparator(cell, tableView: tableView)
            cell.bloodSugarTextField.tag = indexPath.row //1
            cell.bloodSugarTextField.delegate = self
            return cell
            
        default:
            return cell
        }
    }
    
    private func addSeparator(_ cell: UITableViewCell, tableView: UITableView) -> Void {
        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
    
    private func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
}

extension AddBloodSugarDiaryViewController: UITextFieldDelegate {
    
    enum TextFieldData: Int {
        
        case bloodSugarCategoryTextField = 0
        case bloodSugarTextField = 1
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        switch textField.tag {
//        case TextFieldData.bloodSugarCategoryTextField.rawValue:
//            print(text)
//            if text != "Add Category" {
//                bloodSugarCategoryIsFilled = true
//            } else {
//                bloodSugarCategoryIsFilled = false
//            }
        case TextFieldData.bloodSugarTextField.rawValue:
            if !text.isEmpty {
                bloodSugarIsFilled = true
            } else {
                bloodSugarIsFilled = false
            }
        default:
            break
        }
        
        saveButton.isEnabled = isAllDataFilled()
        return true

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        switch textField.tag {
        case TextFieldData.bloodSugarCategoryTextField.rawValue:
            if textField.text != "Add Category" {
                bloodSugarCategoryIsFilled = true
            } else {
                bloodSugarCategoryIsFilled = false
            }
//        case TextFieldData.bloodSugarTextField.rawValue:
//            if textField.text != "" {
//                bloodSugarIsFilled = true
//            } else {
//                bloodSugarIsFilled = false
//            }
        default:
            break
        }

        saveButton.isEnabled = isAllDataFilled()

    }
    
    func isAllDataFilled() -> Bool {
        if bloodSugarIsFilled && bloodSugarCategoryIsFilled {
            return true
        } else {
            return false
        }
    }
}
