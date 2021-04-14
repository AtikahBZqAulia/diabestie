//
//  FoodIntakeViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class FoodIntakeViewController: UIViewController {
    
    @IBOutlet weak var viewCalendar: ExtendedNavBarView!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDate = Date()
    let horizontalCalendar = HorizontalCalendar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage.transparentPixel
        
        setupCalendar()
    }
    
    func setupCalendar(){
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
        if segue.destination is FoodIntakeDataViewController {
            
            let vc = segue.destination as? FoodIntakeDataViewController
            vc?.selectedDate = self.selectedDate
            
        }
    }
    
    
}

extension FoodIntakeViewController: CalendarControllerDelegate {
    
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

extension FoodIntakeViewController {
    func generateSugarChartEntry() -> [BarDataEntry]? {
        
        var result: [BarDataEntry]? = .init()
        
        if let foodIntakeData = foodIntakeDataByDate {
            foodIntakeData.forEach { (entry) in
                let nutrition = foodIntakeNutritionData(entry)
                
                let time: Float = Float(entry.time_log?.string(format: .Hour) ?? "") ?? 0
                result?.append(BarDataEntry(color: UIColor.blueBlue, height: Float(nutrition.sugar), textValue: "\(nutrition.sugar)", title: "\(nutrition.sugar)", time: time))
            }
        }
        
        return result
    }
    func generateCalorieChartEntry() -> [BarDataEntry]? {
        
        var result: [BarDataEntry]? = .init()
        
        if let foodIntakeData = foodIntakeDataByDate {
            foodIntakeData.forEach { (entry) in
                let nutrition = foodIntakeNutritionData(entry)
                let time: Float = Float(entry.time_log?.string(format: .Hour) ?? "") ?? 0
                result?.append(BarDataEntry(color: UIColor.tangerine, height: Float(nutrition.calorie), textValue: "\(nutrition.calorie)", title: "\(nutrition.calorie)", time: time))
            }
        }
        
        return result
    }
    
}

extension FoodIntakeViewController {
    
    var latestFoodEntry: FoodEntries? {
        return foodIntakeDataByDate?.last
    }
    var foodIntakeDataByDate: [FoodEntries]? {
        return FoodEntryRepository.shared.getFoodEntryByDate(date: self.selectedDate)
    }
    func foodIntakeNutritionData(_ entry: FoodEntries) -> (sugar: Int, calorie:Int) {
        return FoodEntryRepository.shared.getFoodEntryTotalNutrition(entry: entry)
    }
    func foodIntakeNutritionData(_ date: Date) -> (sugar: Int, calorie:Int) {
        return FoodEntryRepository.shared.getFoodEntryTotalNutrition(date: date)
    }
    
}

extension FoodIntakeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        identifiers.append(FoodCalIntakeChartCell.identifier)
        identifiers.append(FoodSugarIntakeChartCell.identifier)
        identifiers.append(FoodIntakeInfoCell.identifier)
        
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
        case FoodCalIntakeChartCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodCalIntakeChartCell else {
                return UITableViewCell()
            }
            
            cell.totalCalorie = foodIntakeNutritionData(self.selectedDate).calorie
            cell.selectedDate = self.selectedDate
            cell.calorieLevelData = generateCalorieChartEntry()
            
            cell.selectionStyle = .none
            
            return cell
        case FoodSugarIntakeChartCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodSugarIntakeChartCell else {
                return UITableViewCell()
            }
            
            cell.totalCalorie = foodIntakeNutritionData(self.selectedDate).sugar
            cell.selectedDate = self.selectedDate
            cell.sugarLevelData = generateSugarChartEntry()
            
            cell.selectionStyle = .none
            
            return cell
        case FoodIntakeInfoCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodIntakeInfoCell else {
                return UITableViewCell()
            }
            
            cell.foodEntry = latestFoodEntry
            
            cell.selectionStyle = .none
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}

