//
//  FoodIntakeDetailViewController.swift
//  Diabestie
//
//  Created by Revarino Putra on 03/04/21.
//

import UIKit

class FoodIntakeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var foodDetailTableView: UITableView!
    
    let food = ["","","Pisang", "Nasi", "Marugame", "Boba" , "Kol Goreng"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodDetailTableView.dataSource = self
        foodDetailTableView.register(UINib(nibName: "FoodIntakeDetailTableCell", bundle: nil), forCellReuseIdentifier: "foodDetailCell")
    }

}

extension FoodIntakeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > 1 {
            if let cell = foodDetailTableView.dequeueReusableCell(withIdentifier: "foodDetailCell", for: indexPath) as? FoodIntakeDetailTableCell {

                cell.foodName.text = food[indexPath.row]
                cell.foodGram.text = "100 g"
                cell.foodCal.text = "125 kcal"
                cell.foodSugar.text = "100 mg sugar"
                return cell
            }
            else {
                return UITableViewCell()
            }

        }
        
        else if indexPath.row == 0 {
            if let cell = foodDetailTableView.dequeueReusableCell(withIdentifier: CalculatedFoodTableCell.identifier) as? CalculatedFoodTableCell {
                cell.eatName.text = "Dinner"
                cell.calories.text = String(625)
                cell.sugar.text = String(500)
                cell.eatTime.text = "19.00"
                hideSeparator(cell)
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
            hideSeparator(cell)
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func hideSeparator(_ cell: UITableViewCell) -> Void {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }
}
