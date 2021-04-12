//
//  MedicineIntakeDataViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class MedicineIntakeDataViewController: UIViewController {
    
    @IBOutlet weak var medicineIntakeDataTableView: UITableView!
    
    var medicineEntries: [MedicineEntries] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        medicineEntries = MedicineEntryRepository.shared.getAllMedicineEntry()
        medicineIntakeDataTableView.dataSource = self
        
    }

}

extension MedicineIntakeDataViewController: UITableViewDelegate, UITableViewDataSource {
   
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
        return medicineEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineIntakeDataCell", for: indexPath) as? MedicineIntakeDataCell else {
            return UITableViewCell()
        }
        cell.entry = medicineEntries[indexPath.row]
        return cell
    }
    
    
}

