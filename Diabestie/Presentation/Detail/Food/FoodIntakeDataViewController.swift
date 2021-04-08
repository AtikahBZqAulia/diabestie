//
//  FoodIntakeDataViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class FoodIntakeDataViewController: UIViewController {

    let food = ["","","Pisang", "Nasi", "Marugame", "Boba" , "Kol Goreng"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataCell = tableView.dequeueReusableCell(withIdentifier: FoodIntakeDataCell.cellIdentifier(), for: indexPath) as? FoodIntakeDataCell {
            return dataCell
        }
        else {
            return UITableViewCell()
        }
    }
    
}
