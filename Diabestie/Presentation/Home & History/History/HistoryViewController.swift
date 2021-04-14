//
//  HistoryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var viewCalendar: ExtendedNavBarView!
    @IBOutlet weak var tableView: UITableView!
    
    let horizontalCalendar = HorizontalCalendar()
    var selectedDate: Date = Date()
    
    var todayHistoryData : [Any] =  [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage.transparentPixel
        
        setupTableView()
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
        
        todayHistoryData = todayHistoryData.sorted(by:{ data, value in
            
            let data = data as! NSManagedObject
            let value = value as! NSManagedObject
            let startDate = data.value(forKey: "updated_at") as! Date
            let endDate = value.value(forKey: "updated_at") as! Date

            return startDate < endDate
        })
        
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
    
    func setupTableView(){
        tableView.register(UINib(nibName: BloodSugarTableCell.identifier, bundle: nil), forCellReuseIdentifier: BloodSugarTableCell.identifier)
        tableView.register(UINib(nibName: FoodTableCell.identifier, bundle: nil), forCellReuseIdentifier: FoodTableCell.identifier)
        tableView.register(UINib(nibName: MedicineTableCell.identifier, bundle: nil), forCellReuseIdentifier: MedicineTableCell.identifier)
        tableView.register(UINib(nibName: EmptyStateCellTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmptyStateCellTableViewCell.identifier)

    }
    
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
        
        if todayHistoryData.isEmpty {
            identifiers.append(EmptyStateCellTableViewCell.identifier)
        } else {
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
        }

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
            
            cell.isHistory = true
            cell.bloodSugarEntry = todayHistoryData[indexPath.row] as? BloodSugarEntries
            
            return cell
        case FoodTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodTableCell else {
                return UITableViewCell()
            }
            
            cell.isHistory = true
            cell.foodEntry = todayHistoryData[indexPath.row] as? [FoodEntries]

            return cell
        case MedicineTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MedicineTableCell else {
                return UITableViewCell()
            }
            
            cell.isHistory = true
            cell.icChevron.isHidden = false
            cell.medicineEntry = todayHistoryData[indexPath.row] as? MedicineEntries

            return cell
        case EmptyStateCellTableViewCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? EmptyStateCellTableViewCell else {
                return UITableViewCell()
            }
            
            cell.lblDescription.text = "You don't have any entries yet"
            return cell
        default:
            return cell
        }
    }
    
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let identifier = self.tableviewIdentifier()[indexPath.row]
        
        switch identifier {
        case MedicineTableCell.identifier:
            return 115
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = self.tableviewIdentifier()[indexPath.row]
        
        switch identifier {
        case BloodSugarTableCell.identifier:
            self.performSegue(withIdentifier: "BloodSugarDataSegue", sender: nil)
        case FoodTableCell.identifier:
            self.performSegue(withIdentifier: "FoodIntakeDataSegue", sender: nil)
        case MedicineTableCell.identifier:
            self.performSegue(withIdentifier: "MedicineIntakeDataSegue", sender: nil)
        default:
            print("No action")
        }
    }
}

