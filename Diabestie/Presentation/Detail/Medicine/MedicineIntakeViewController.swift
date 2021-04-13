//
//  MedicineIntakeViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class MedicineIntakeViewController: UIViewController {
    
    @IBOutlet weak var viewCalendar: ExtendedNavBarView!
    @IBOutlet weak var medicineIntakeTableView: UITableView!
    
    var medicineEntries: [MedicineEntries] = []
    var medicineLibrary: [MedicineLibrary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //To-Do
        //medicineEntries blm query supaya cuma ambil entries sesuai tangal yang dipilih
        medicineEntries = MedicineEntryRepository.shared.getAllMedicineEntry() //masih all medicine entries
        medicineLibrary = MedicineLibraryRepository.shared.getAllMedicineLibrary()
        
        medicineIntakeTableView.dataSource = self
        
        self.navigationController?.navigationBar.shadowImage = UIImage.transparentPixel
        
        let calendar = HorizontalCalendar()
        
        viewCalendar.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: viewCalendar.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leftAnchor.constraint(equalTo: viewCalendar.leftAnchor),
            calendar.rightAnchor.constraint(equalTo: viewCalendar.rightAnchor)
        ])
        
    }
}

extension MedicineIntakeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        while case var index = 0, index < medicineLibrary.count {
            identifiers.append(MedicineIntakeCell.identifier)
            index += 1
        }
        
        identifiers.append(MedicineIntakeInfoCell.identifier)
        identifiers.append(MedicineIntakeOptionCell.identifier)
        
        return identifiers
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(Constants.footerHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineEntries.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = self.tableviewIdentifier()[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        
        switch identifier {
        case MedicineIntakeCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MedicineIntakeCell else {
                return UITableViewCell()
            }
            cell.library = medicineLibrary[indexPath.row]
            cell.selectionStyle = .none
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
