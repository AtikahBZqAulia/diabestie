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
    @IBOutlet weak var buttonAdd: UIButton!
    
    var saveButton: UIBarButtonItem!
    weak var delegate: MedicineEntryDelegate?
    var selectedCategory: Int = 0
    
    static let identifier = "informationSection"

    override func awakeFromNib() {
        super.awakeFromNib()
        createPickerView()
        dismissPickerView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        delegate?.onDateSelected(selectedDate: sender.date)
    }
}

extension InformationTableCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func medicineCategoryChoice() -> [String] {
        return Constants.medCategoryList
    }
    
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
        return Constants.medCategoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.medCategoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = row
        categoryField.text = medicineCategoryChoice()[selectedCategory]
        delegate?.onCategoryPick(categoryId: selectedCategory)
        if medicineCategoryChoice()[selectedCategory] == "Add Category" {
            buttonAdd.isHidden = false
        }else { buttonAdd.isHidden = true }
    }
}
