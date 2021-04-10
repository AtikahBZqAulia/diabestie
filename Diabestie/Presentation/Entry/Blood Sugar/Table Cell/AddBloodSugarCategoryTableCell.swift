//
//  AddBloodSugarCategoryTableCell.swift
//  Diabestie
//
//  Created by Wuri Dita on 06/04/21.
//

import UIKit

class AddBloodSugarCategoryTableCell: UITableViewCell {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bloodSugarCategoryTextField: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    
    static let identifier = "AddBloodSugarCategoryTableCell"
    
    weak var delegate: AddBloodSugarDelegate?
    var selectedCategory: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        
        customTextFieldView()
        createPickerView()
        dismissPickerView()
        setupDate()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupDate() {
        datePicker.setDate(Date(), animated: true)
    }
}

extension AddBloodSugarCategoryTableCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func bloodSugarCategoryChoice() -> [String] {
        return Constants.categoryList
    }
    
    func customTextFieldView() {
        bloodSugarCategoryTextField.attributedPlaceholder = NSAttributedString(string: "Add Category", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        bloodSugarCategoryTextField.tintColor = UIColor.clear
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        bloodSugarCategoryTextField.inputView = pickerView
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
        bloodSugarCategoryTextField.inputAccessoryView = pickerViewToolBar
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
        
        selectedCategory = row
        bloodSugarCategoryTextField.text = bloodSugarCategoryChoice()[selectedCategory]
        
        delegate?.onCategoryPick(categoryId: selectedCategory)
        switch bloodSugarCategoryChoice()[row] {
        case "Add Category":
            plusButton.isHidden = false
            
        default:
            plusButton.isHidden = true
        }
    }
    
    @objc func onDoneButtontapped() {
        bloodSugarCategoryTextField.endEditing(true)
    }
    
}
