//
//  InformationTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 08/04/21.
//

import UIKit

class InformationTableCell: UITableViewCell {
    
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedCategory: String?
    let categoryList = ["Fasting", "After Breakfast", "After Lunch", "After Dinner"]
    
    static let identifier = "informationSection"

    override func awakeFromNib() {
        super.awakeFromNib()
        createPickerView()
        dismissPickerView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

extension InformationTableCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        categoryField.inputView = pickerView
        categoryField.tintColor = UIColor.clear
    }
    
    func dismissPickerView() {
             let toolBar = UIToolbar()
             toolBar.isUserInteractionEnabled = true
             toolBar.backgroundColor = UIColor.white
             toolBar.sizeToFit()

             let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtontapped))
             toolBar.setItems([doneButton], animated: true)

             categoryField.inputAccessoryView = toolBar
    }
    
    @objc func onDoneButtontapped() {
             categoryField.endEditing(true)
    }
  
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categoryList[row]
        categoryField.text = selectedCategory
    }
}
