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
    @IBOutlet weak var buttonAdd: UIButton!

    var saveButton: UIBarButtonItem!
    weak var delegate: FoodEntryDelegate?
    var selectedCategory: Int = 0
    
    static let identifier = "FoodInformationTableCell"
    
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

extension FoodInformationTableCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func foodCategoryChoice() -> [String] {
        return Constants.mealCategoryList
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        addCategory.inputView = pickerView
        addCategory.tintColor = UIColor.white
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
        return Constants.mealCategoryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.mealCategoryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = row
        addCategory.text = foodCategoryChoice()[selectedCategory]
        delegate?.onCategoryPick(categoryId: selectedCategory)
        if foodCategoryChoice()[selectedCategory] == "Add Category" {
            buttonAdd.isHidden = false
        }else { buttonAdd.isHidden = true }
    }
}
