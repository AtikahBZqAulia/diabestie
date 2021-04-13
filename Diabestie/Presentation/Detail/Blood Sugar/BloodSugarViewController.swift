//
//  BloodSugarViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class BloodSugarViewController: UIViewController {
    
    @IBOutlet weak var viewCalendar: ExtendedNavBarView!
    
    var selectedDate: Date = Date()
    
    @IBOutlet weak var tableView: UITableView!
    
    let horizontalCalendar = HorizontalCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//            self.onDateSelected(date: date)
            if date != self.selectedDate {
                self.selectedDate = date
    //            self.horizontalCalendar.selectedDate = self.selectedDate
    //            self.horizontalCalendar.setSelectedDate()
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
        if segue.destination is BloodSugarDataViewController {
            
            let vc = segue.destination as? BloodSugarDataViewController
            vc?.selectedDate = self.selectedDate

        }
    }
    
}

extension BloodSugarViewController: CalendarControllerDelegate {
    
    func onDateSelected(date: Date) {
        print("sadsad")
        if date != self.selectedDate {
            self.selectedDate = date
//            self.horizontalCalendar.selectedDate = self.selectedDate
            self.horizontalCalendar.setSelectedDate(selectedDate: date)
            self.tableView.reloadData()
        }
    }
}

extension BloodSugarViewController {
    
    func generateBarchartEntry() -> [BarDataEntry]? {
        
        var result: [BarDataEntry]? = .init()
        
        if let bloodSugarEntries = bloodSugarEntriesByDate {
            
            bloodSugarEntries.forEach { (entry) in
                let indicator = BloodSugarEntryRepository.shared.sugarLevelIndicator(bloodSugarEntry: entry)
                let time: Float = Float(entry.time_log?.string(format: .Hour) ?? "") ?? 0
                let barColor = Constants.BloodSugarLevelIndicatorTxtColor(indicator: indicator)
                result?.append(BarDataEntry(color: barColor, height: Float(entry.blood_sugar ), textValue: "\(entry.blood_sugar )", title: "\(entry.blood_sugar )", time: time))
            }
        }
        
        return result
    }
    
    func generateBarChartThreshold() -> [BarChartThresholdDataEntry]? {
        
        var result: [BarChartThresholdDataEntry]? = .init()
        
        if let bloodSugarConstraint = getBloodSugarConstraint {
            
            result?.append(BarChartThresholdDataEntry.init(color: UIColor.purpleMedicine60, value: Int(bloodSugarConstraint.am_lower_bound)))
            result?.append(BarChartThresholdDataEntry.init(color: UIColor.reddishPink60, value: Int(bloodSugarConstraint.am_upper_bound)))
            result?.append(BarChartThresholdDataEntry.init(color: UIColor.deepSkyBlue60, value: Int(bloodSugarConstraint.f_upper_bound)))
            result?.append(BarChartThresholdDataEntry.init(color: UIColor.tangerine60, value: Int(bloodSugarConstraint.f_lower_bound)))
            
        }
        
        return result
    }
    
    var getBloodSugarConstraint: BloodSugarConstraints? {
        return UserRepository.shared.getCurrentUser()?.bloodsugarconstraint
    }
    
    var bloodSugarEntriesByDate: [BloodSugarEntries]? {
        return BloodSugarEntryRepository.shared.getBloodSugarEntryByDate(date: selectedDate)
    }
    
    var latestBloodSugarEntriesByDate : BloodSugarEntries? {
        return bloodSugarEntriesByDate?.last
    }
    
    var currentUser: Users? {
        return UserRepository.shared.getCurrentUser()
    }
    
}

extension BloodSugarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        identifiers.append(BloodSugarChartCell.identifier)
        
        //Check if current date has blood sugar entries
        if bloodSugarEntriesByDate?.count ?? 0 > 0{
            
            //Check if user has set their constraints
            if getBloodSugarConstraint != nil {
                identifiers.append(BloodSugarThresholdCell.identifier)
            }
            
            identifiers.append(BloodSugarInfoCell.identifier)
        }
        
        identifiers.append(BloodSugarOptionCell.identifier)
        
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
        case BloodSugarChartCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BloodSugarChartCell else {
                return UITableViewCell()
            }
            
            cell.todayDate = selectedDate
            
            cell.bloogSugarDataRange = BloodSugarEntryRepository.sugarLevelRange(date: selectedDate)
            
            cell.chartThreshold = generateBarChartThreshold()
            cell.bloodSugarChartData = generateBarchartEntry()
            
            
            cell.selectionStyle = .none
            
            return cell
        case BloodSugarInfoCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BloodSugarInfoCell else {
                return UITableViewCell()
            }
            
            cell.bloodSugarLatestEntryTime = latestBloodSugarEntriesByDate?.time_log
            cell.bloodSugarIndicator = BloodSugarEntryRepository.shared.sugarLevelIndicator(bloodSugarEntry: latestBloodSugarEntriesByDate)
            
            cell.selectionStyle = .none
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
