//
//  ViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 24/03/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddDiaryTableCell.identifier) else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BloodSugarTableCell.identifier) else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableCell.identifier) else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MedicineTableCell.identifier) else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryHistoryTableCell.identifier) else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        return cell
    }
    
    
}
