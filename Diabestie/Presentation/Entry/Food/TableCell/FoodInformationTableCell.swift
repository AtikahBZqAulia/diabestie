//
//  FoodInformationTableCell.swift
//  Diabestie
//
//  Created by Wilson Adrilia on 08/04/2021.
//

import UIKit

class FoodInformationTableCell: UITableViewCell{
    
    @IBOutlet weak var addCategory: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var buttonCategory: UIButton!
    
    var selectedCategory: String?
    let categoryList = ["Breakfast", "Lunch", "Dinner", "Snacks"]
    
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

extension FoodInformationTableCell: UIPickerViewDataSource, UIPickerViewDelegate{
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        addCategory.inputView = pickerView
        addCategory.tintColor = UIColor.clear
    }
    
    func dismissPickerView() {
             let toolBar = UIToolbar()
             toolBar.isUserInteractionEnabled = true
             toolBar.backgroundColor = UIColor.white
             toolBar.sizeToFit()

             let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtontapped))
             toolBar.setItems([doneButton], animated: true)

             addCategory.inputAccessoryView = toolBar
    }
    
    @objc func onDoneButtontapped() {
             addCategory.endEditing(true)
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
        addCategory.text = selectedCategory
        buttonCategory.isHidden = true
    }
}
