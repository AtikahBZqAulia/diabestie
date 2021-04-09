//
//  AddBloodSugarCategoryTableCell.swift
//  Diabestie
//
//  Created by Wuri Dita on 06/04/21.
//

import UIKit

class AddBloodSugarCategoryTableCell: UITableViewCell {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addCategoryInput: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    
    static let identifier = "AddBloodSugarCategoryTableCell"
    var selectedCategory: String = ""
    var bloodSugar: String = ""
    //var delegate: addBloodSugarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customTextFieldView()
        createPickerView()
        dismissPickerView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension AddBloodSugarCategoryTableCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func bloodSugarCategoryChoice() -> [String] {
        let categoryList = ["Add Category", "Fasting", "After Breakfast", "After Lunch", "After Dinner"]
        
        return categoryList
    }
    
    func customTextFieldView() {
        addCategoryInput.attributedPlaceholder = NSAttributedString(string: "Add Category", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        addCategoryInput.tintColor = UIColor.clear
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        addCategoryInput.inputView = pickerView
    }
    
    func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.isUserInteractionEnabled = true
        toolBar.backgroundColor = UIColor.white
        toolBar.sizeToFit()
        
        return toolBar
    }
    
    func createBarButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtontapped))
        button.tintColor = UIColor.blueBlue
        
        return button
    }
    
    func dismissPickerView() {
        let pickerViewToolBar = createToolBar()
        let doneButton = createBarButton()
        
        pickerViewToolBar.setItems([doneButton], animated: true)
        addCategoryInput.inputAccessoryView = pickerViewToolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodSugarCategoryChoice().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodSugarCategoryChoice()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        plusButton.isHidden = true
        
        selectedCategory = bloodSugarCategoryChoice()[row]
        addCategoryInput.text = selectedCategory
        
        switch bloodSugarCategoryChoice()[row] {
        case "Add Category":
            plusButton.isHidden = false
            
        default:
            break
        }
    }
    
    @objc func onDoneButtontapped() {
        addCategoryInput.endEditing(true)
    }
    
}

//protocol addBloodSugarDelegate {
//    func setSaveButtonStage(_ stage: Bool)
//}
