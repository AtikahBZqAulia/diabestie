//
//  AddBloodSugarDiaryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit


//Use protocol to pass data between cell & view controller
protocol AddBloodSugarDelegate: class {
    func onCategoryPick(categoryId: Int)
    func onBloodSugarLevel(bloodSugarLevel: Int)
    func onDateSelected(selectedDate: Date)
}

class AddBloodSugarDiaryViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var selectedCategory: Int = 0 {
        didSet {
            validateData()
        }
    }
    var bloodSugarLevel: Int = 0 {
        didSet {
            validateData()
        }
    }
    var timeLog = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false

    }
    
    @IBAction func onSaveButtonTap(_ sender: Any) {
        saveBloodSugarData()
    }
    
    @IBAction func backToPreviousPage(_ sender: UIBarButtonItem) {
        self.popBack(2)
    }

}

extension AddBloodSugarDiaryViewController: AddBloodSugarDelegate {
    
    func onCategoryPick(categoryId: Int) {
        self.selectedCategory = categoryId
    }
    
    func onDateSelected(selectedDate: Date) {
        self.timeLog = selectedDate
    }
    func onBloodSugarLevel(bloodSugarLevel: Int) {
        self.bloodSugarLevel = bloodSugarLevel
    }
    
}

extension AddBloodSugarDiaryViewController {
    
    func saveBloodSugarData() {
        BloodSugarEntryRepository.shared.insertBloodSugarEntry(category: self.selectedCategory, bloodSugar: bloodSugarLevel, timeLog: timeLog)
//        self.navigationController?.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    func validateData(){
        if selectedCategory == 0 {
            self.saveButton.tintColor = .charcoalGrey
            saveButton.isEnabled = false
            return
        }
        if bloodSugarLevel == 0 {
            self.saveButton.tintColor = .charcoalGrey
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
        self.saveButton.tintColor = .blueBlue
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
            
            cell.delegate = self
            return cell
            
        case AddBloodSugarTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddBloodSugarTableCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            addSeparator(cell, tableView: tableView)
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
