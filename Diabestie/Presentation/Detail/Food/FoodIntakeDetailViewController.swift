//
//  FoodIntakeDetailViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class FoodIntakeDetailViewController: UIViewController {
    
    @IBOutlet weak var foodDetailTableView: UITableView!
    
    var foodEntries: FoodEntries?
    var baskets: [FoodBasket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodDetailTableView.dataSource = self
        
        guard let entries = foodEntries?.foodbasket?.allObjects as? [FoodBasket] else {
            return
        }
        baskets = entries
    }

}

extension FoodIntakeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return baskets.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > 1 {
            if let cell = foodDetailTableView.dequeueReusableCell(withIdentifier: "FoodIntake", for: indexPath) as? FoodIntakeDetailTableCell {
                
                cell.foodName.text = "\(baskets[indexPath.row - 2].foodlibrary!.food_name ?? "")"
                cell.foodGram.text = "\(baskets[indexPath.row - 2].foodlibrary!.weight) g"
                cell.foodCal.text = "\(baskets[indexPath.row - 2].foodlibrary!.calories) kcal"
                cell.foodSugar.text = "\(baskets[indexPath.row - 2].foodlibrary!.sugar) mg sugar"
                
                if indexPath.row == 2 && indexPath.row == baskets.count + 1 {
                    cell.foodListView.clipsToBounds = true
                    cell.foodListView.layer.cornerRadius = 12
                    cell.foodListView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                }
                else if indexPath.row == 2 {
                    setBorder(cell, .layerMaxXMinYCorner, .layerMinXMinYCorner)
                }
                else if indexPath.row == baskets.count + 1 {
                    setBorder(cell, .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
                }
                if indexPath.row > 2 && indexPath.row <= baskets.count + 1 {
                    addSeparator(cell)
                }
                return cell
            }
            else {
                return UITableViewCell()
            }

        }
        
        else if indexPath.row == 0 {
            if let cell = foodDetailTableView.dequeueReusableCell(withIdentifier: CalculatedFoodTableCell.identifier) as? CalculatedFoodTableCell {
                let total = getTotal()
                cell.eatName.text = "\(Constants.mealCategoryList[Int(foodEntries?.eat_time ?? 0)])"
                cell.calories.text = "\(total.calories)"
                cell.sugar.text = "\(total.sugar)"
                cell.eatTime.text = "\(foodEntries?.time_log?.string(format: .HourMinutes) ?? "")"
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
        
        else if indexPath.row == 1 {
            guard let cell = foodDetailTableView.dequeueReusableCell(withIdentifier: "labelCell") else {
                return UITableViewCell()
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func getTotal() -> (calories: Int, sugar: Int) {
        var totalCalories: Int = 0
        var totalSugar: Int = 0
        for data in baskets {
            totalCalories += Int(data.foodlibrary!.calories) * Int(data.qty)
            totalSugar += Int(data.foodlibrary!.sugar) * Int(data.qty)
        }
        return (totalCalories, totalSugar)
    }
    
    
    
    private func setBorder(_ dataCell:FoodIntakeDetailTableCell  , _ right: CACornerMask, _ left: CACornerMask) -> Void {
        dataCell.foodListView.clipsToBounds = true
        dataCell.foodListView.layer.cornerRadius = 12
        dataCell.foodListView.layer.maskedCorners = [right, left]
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: 32, y: 0, width: 342, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
    
}
