//
//  FoodIntakeDataViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class FoodIntakeDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var foodEntries: [FoodEntries] = []
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodEntries = FoodEntryRepository.shared.getFoodEntryByDate(date: selectedDate)
        tableView.reloadData()
    }

}

extension FoodIntakeDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        header.textLabel?.textColor = .charcoalGrey
        header.textLabel?.text =  header.textLabel?.text?.capitalized

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "FOOD ENTRIES"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataCell = tableView.dequeueReusableCell(withIdentifier: FoodIntakeDataCell.cellIdentifier(), for: indexPath) as? FoodIntakeDataCell {
            let idxName: Int = Int(foodEntries[indexPath.row].eat_time)
            let idxTime: Date = foodEntries[indexPath.row].time_log!
            dataCell.eatTime.text = "\(Constants.mealCategoryList[idxName])"
            dataCell.timeLog.text = "\(idxTime.string(format: .HourMinutes))"
            return dataCell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FoodIntakeDetailViewController") as? FoodIntakeDetailViewController
        vc?.foodEntries = foodEntries[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
