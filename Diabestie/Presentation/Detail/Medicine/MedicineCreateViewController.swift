//
//  MedicineCreateViewController.swift
//  Diabestie
//
//  Created by Revarino Putra on 08/04/21.
//

import UIKit

protocol CreateMedicineDelegate: class {
    func medicineName(name: String)
    func consumption(frequency: Int)
}

class MedicineCreateViewController: UITableViewController {

    @IBOutlet var createMedicineView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var inputtedName: String = "" {
        didSet {
            validateData()
        }
    }
    var inputtedFrequency: Int = 0 {
        didSet {
            validateData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftItemsSupplementBackButton = false
        saveButton.isEnabled = false
    }
    
    func validateData() {
        if inputtedName.isEmpty || inputtedFrequency == 0 {
            saveButton.isEnabled = false
            saveButton.tintColor = .charcoalGrey
            return
        }
        saveButton.isEnabled = true
        saveButton.tintColor = .blueBlue
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func viewIdentifier() -> [String] {
        var identifiers = [String]()
        identifiers.append("InformationCell")
        identifiers.append(InputMedicineNameTableCell.identifier)
        identifiers.append(MedicineFrequencyTableCell.identifier)
        
        return identifiers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = viewIdentifier()[indexPath.row]
        guard let cell = createMedicineView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        switch identifier {
        case InputMedicineNameTableCell.identifier:
            guard let cell = createMedicineView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? InputMedicineNameTableCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        case MedicineFrequencyTableCell.identifier:
            guard let cell = createMedicineView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MedicineFrequencyTableCell else {
                return UITableViewCell()
            }
            addSeparator(cell)
            cell.delegate = self
            return cell
        default:
            return cell
        }
    }

    @IBAction func save(_ sender: Any) {
        saveData()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
    
    func saveData() {
        MedicineLibraryRepository.shared.insertMedicineLibrary(name: self.inputtedName, consumption: self.inputtedFrequency)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

extension MedicineCreateViewController: CreateMedicineDelegate {
    func medicineName(name: String) {
        self.inputtedName = name
    }
    
    func consumption(frequency: Int) {
        self.inputtedFrequency = frequency
    }
    
    
}
