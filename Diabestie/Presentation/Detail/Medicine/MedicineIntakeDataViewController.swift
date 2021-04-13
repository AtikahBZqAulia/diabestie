//
//  MedicineIntakeDataViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class MedicineIntakeDataViewController: UIViewController {
    
    @IBOutlet weak var medicineIntakeDataTableView: UITableView!
    
    var selectedDate = Date()
    var medicineData: [Any] = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        medicineIntakeDataTableView.dataSource = self
        
        setupTableView()
        setupMedicineData()
        
    }
}

extension MedicineIntakeDataViewController {
    var medicineEntries : [MedicineEntries]? {
        return MedicineEntryRepository.shared.getMedicineEntryByDate(date: selectedDate)
        
    }
    
    func setupMedicineData() {
        medicineData.removeAll()
        
        medicineEntries?.forEach({ (entry) in
            medicineData.append(entry)
        })
    }
}

extension MedicineIntakeDataViewController: UITableViewDelegate, UITableViewDataSource {
   
    func setupTableView(){
        medicineIntakeDataTableView.register(UINib(nibName: MedicineTableCell.identifier, bundle: nil), forCellReuseIdentifier: MedicineTableCell.identifier)

    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        header.textLabel?.textColor = .charcoalGrey

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Medicine Entries".capitalized
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(Constants.footerHeight)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineEntries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MedicineTableCell.identifier, for: indexPath) as? MedicineTableCell else {
            return UITableViewCell()
        }
        cell.isHistory = true
        cell.medicineEntry = medicineData[(medicineEntries?.count ?? 0) - indexPath.row - 1] as? MedicineEntries
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    
}

