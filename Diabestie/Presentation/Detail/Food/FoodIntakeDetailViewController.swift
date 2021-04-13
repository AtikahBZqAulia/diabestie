//
//  FoodIntakeDetailViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class FoodIntakeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var foodDetailTableView: UITableView!
    
//    let food = ["Pisang", "Nasi", "Marugame", "Boba" , "Kol Goreng"]
    var foodEntries: FoodEntries!
    var foodBasket: [FoodBasket] = []
    var newBasket: [FoodBasket] = []
    var baskets = NSMutableSet.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodDetailTableView.dataSource = self
        foodBasket = FoodBasketRepository.shared.getAllFoodBasket()
        baskets = foodEntries.foodbasket! as! NSMutableSet
        for basket in foodBasket {
            if basket.ofFoodEntry == foodEntries && basket.foodlibrary != nil {
                newBasket.append(basket)
            }
        }
    }

}

extension FoodIntakeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newBasket.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > 1 {
            if let cell = foodDetailTableView.dequeueReusableCell(withIdentifier: "FoodIntake", for: indexPath) as? FoodIntakeDetailTableCell {
                
                cell.foodName.text = "\(newBasket[indexPath.row - 2].foodlibrary!.food_name ?? "")"
                cell.foodGram.text = "100 g"
                cell.foodCal.text = "125 kcal"
                cell.foodSugar.text = "100 mg sugar"
                if indexPath.row == 2 {
                    setBorder(cell, .layerMaxXMinYCorner, .layerMinXMinYCorner)
                }
                else if indexPath.row == newBasket.count + 1 {
                    setBorder(cell, .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
                }
                if indexPath.row > 2 && indexPath.row <= newBasket.count + 1 {
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
                cell.eatName.text = "Dinner"
                cell.calories.text = String(625)
                cell.sugar.text = String(500)
                cell.eatTime.text = "19.00"
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
