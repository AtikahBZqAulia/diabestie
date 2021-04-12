//
//  HistoryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var viewCalendar: ExtendedNavBarView!
    @IBOutlet weak var tableView: UITableView!
    
    let horizontalCalendar = HorizontalCalendar()
    var selectedDate: Date = Date()
    
    var todayHistoryData : [Any] =  [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage.transparentPixel
        
        setupHorizontalCalendar()
        
        setupHistoryData()
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
                self.setupHistoryData()
                self.tableView.reloadData()
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
    }
    
}

extension HistoryViewController {
    var bloodSugarList: [BloodSugarEntries]? {
        return BloodSugarEntryRepository.shared.getBloodSugarEntryByDate(date: selectedDate)
    }
    
    var foodIntakeList: [FoodEntries]? {
        return FoodEntryRepository.shared.getFoodEntryByDate(date: selectedDate)
    }
    
    var medicineList: [MedicineEntries]? {
        return MedicineEntryRepository.shared.getMedicineEntryByDate(date: selectedDate)
    }
    
    func setupHistoryData(){
        todayHistoryData.removeAll()
        
        medicineList?.forEach({ (entry) in
            todayHistoryData.append(entry)
        })
        foodIntakeList?.forEach({ (entry) in
            todayHistoryData.append(entry)
        })
        bloodSugarList?.forEach({ (entry) in
            todayHistoryData.append(entry)
        })
        
        todayHistoryData.sorted(by:
                                    { data, value in
                                        
                                        if let value = value as? MedicineEntries, let data = data as? MedicineEntries {
                                            return data.time_log!.compare(value.time_log!) == .orderedAscending
                                        }
                                        if let value = value as? BloodSugarEntries, let data = data as? BloodSugarEntries  {
                                            return data.time_log!.compare(value.time_log!) == .orderedAscending
                                        }
                                        if let value = value as? FoodEntries, let data = data as? FoodEntries  {
                                            return data.time_log!.compare(value.time_log!) == .orderedAscending
                                        }
                                        
                                        return false
                                    }
        )
        
        
    }
}

extension HistoryViewController: CalendarControllerDelegate {
    func onDateSelected(date: Date) {
        if date != self.selectedDate {
            self.selectedDate = date
            self.setupHistoryData()
            self.horizontalCalendar.setSelectedDate(selectedDate: date)
            self.tableView.reloadData()
        }
    }
}

extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        header.textLabel?.textColor = .black
        header.textLabel?.text =  header.textLabel?.text?.capitalized
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return selectedDate.string(format: .DayMonth)
    }
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        todayHistoryData.forEach { value  in
            if value is MedicineEntries {
                identifiers.append(MedicineTableCell.identifier)
            }
            if value is BloodSugarEntries {
                identifiers.append(BloodSugarTableCell.identifier)
            }
            if value is FoodEntries {
                identifiers.append(FoodTableCell.identifier)
            }
        }
        
        //        identifiers.append(AddDiaryTableCell.identifier)
        //        identifiers.append(DiaryHistoryTableCell.identifier)
        
        return identifiers
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(Constants.footerHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewIdentifier().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = self.tableviewIdentifier()[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        
        switch identifier {
        case AddDiaryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddDiaryTableCell else {
                return UITableViewCell()
            }
            return cell
        case BloodSugarTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BloodSugarTableCell else {
                return UITableViewCell()
            }
            
//            let asd = todayHistoryData[0]
            cell.isHistory = true
            cell.bloodSugarEntry = todayHistoryData[indexPath.row] as? BloodSugarEntries
            
            return cell
        case FoodTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodTableCell else {
                return UITableViewCell()
            }
            return cell
        case MedicineTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MedicineTableCell else {
                return UITableViewCell()
            }
            return cell
        case DiaryHistoryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DiaryHistoryTableCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return cell
        }
    }
    
    
}

