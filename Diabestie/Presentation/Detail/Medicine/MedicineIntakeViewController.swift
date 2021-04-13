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
    
    var selectedDate: Date = Date()
    let horizontalCalendar = HorizontalCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicineIntakeTableView.dataSource = self
        
        self.navigationController?.navigationBar.shadowImage = UIImage.transparentPixel
        
        setupHorizontalCalendar()
    }
    
    func setupHorizontalCalendar(){
        
        viewCalendar.addSubview(horizontalCalendar)
        horizontalCalendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalCalendar.topAnchor.constraint(equalTo: viewCalendar.safeAreaLayoutGuide.topAnchor, constant: 0),
            horizontalCalendar.leftAnchor.constraint(equalTo: viewCalendar.leftAnchor),
            horizontalCalendar.rightAnchor.constraint(equalTo: viewCalendar.rightAnchor)
        ])
        
        horizontalCalendar.onSelectionChanged = { date in
            if date != self.selectedDate {
                self.selectedDate = date
                self.medicineIntakeTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UINavigationController {
            
            let segueNavigationController = segue.destination as? UINavigationController
            
            if let vc = segueNavigationController?.topViewController as? CalendarController {
                vc.delegate = self
                vc.selectedDate = self.selectedDate
            }
            
        }
        if segue.destination is MedicineIntakeDataViewController {
            
            let vc = segue.destination as? MedicineIntakeDataViewController
            vc?.selectedDate = self.selectedDate
        }
    }
    
}

extension MedicineIntakeViewController {
    var medicineLibrary : [MedicineLibrary]? {
        return MedicineLibraryRepository.shared.getAllMedicineLibrary()
        
    }
}

extension MedicineIntakeViewController: CalendarControllerDelegate {
    
    func onDateSelected(date: Date) {
        if date != self.selectedDate {
            self.selectedDate = date
            self.horizontalCalendar.setSelectedDate(selectedDate: date)
            self.medicineIntakeTableView.reloadData()
        }
    }
}

extension MedicineIntakeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        var index = 0
        while index < medicineLibrary?.count ?? 0 {
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
        return (medicineLibrary?.count ?? 0) + 2
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
            cell.selectedDate = self.selectedDate
            cell.library = medicineLibrary?[indexPath.row]
            cell.selectionStyle = .none
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
