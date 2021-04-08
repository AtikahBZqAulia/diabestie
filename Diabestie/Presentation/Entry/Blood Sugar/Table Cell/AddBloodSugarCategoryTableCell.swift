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
    
    static let identifier = "AddBloodSugarCategoryTableCell"
    var selectedCategory: String = ""
    var bloodSugar: String = ""
    
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
        let categoryList = ["Fasting", "After Breakfast", "After Lunch", "After Dinner"]
        
        return categoryList
    }
    
    func customTextFieldView() {
        addCategoryInput.attributedPlaceholder = NSAttributedString(string: "Add Category", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        addCategoryInput.tintColor = UIColor.clear
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        addCategoryInput.inputView = pickerView
        addCategoryInput.backgroundColor = UIColor.white
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.isUserInteractionEnabled = true
        toolBar.backgroundColor = UIColor.white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtontapped))
        toolBar.setItems([doneButton], animated: true)
        
        addCategoryInput.inputAccessoryView = toolBar
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
        selectedCategory = bloodSugarCategoryChoice()[row]
        addCategoryInput.text = selectedCategory
    }
    
    @objc func onDoneButtontapped() {
        addCategoryInput.endEditing(true)
    }
    
}

extension AddBloodSugarCategoryTableCell {
     
    func customDatePickerView() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM dd HH:HH"
//        datePicker.textInputMode = dateFormatter.string(from: datePicker.date)
    }
    
}
