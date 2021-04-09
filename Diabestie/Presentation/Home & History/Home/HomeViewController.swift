//
//  ViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 24/03/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func deleteAllLocalData(_ sender: Any) {
        
        CommonFunction.shared.showAlertWithCompletion(self, title: "Alert", message: "Delete all data?") {
            CoreDataManager.sharedManager.deleteAllData()
            self.tableView.reloadData()
        } failureBlock: {
            // no action yet
        }
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        identifiers.append(BloodSugarTableCell.identifier)
        //        identifiers.append(FoodTableCell.identifier)
        //        identifiers.append(MedicineTableCell.identifier)
        //        identifiers.append(BloodSugarTableCell.emptyStateidentifier)
        identifiers.append(FoodTableCell.emptyStateidentifier)
        identifiers.append(MedicineTableCell.emptyStateidentifier)
        identifiers.append(AddDiaryTableCell.identifier)
        
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
        print("IDENTIFIER \(identifier)")
        
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
        case BloodSugarTableCell.emptyStateidentifier:
            print("IDENTIFIER \(identifier)")

            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyStateCell.cellIdentifier()) as? HomeEmptyStateCell else {
                return UITableViewCell()
            }
            
            cell.lblTitle.text = "Blood Sugar Level"
            cell.lblDescription.text = "Woi, sini absen gula dulu"
            cell.lblTitle.textColor = .redOrange
            cell.icEmptyState.image = UIImage(systemName: "drop.fill")
            cell.icEmptyState.tintColor = .redOrange
        
            return cell
        case FoodTableCell.emptyStateidentifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyStateCell.cellIdentifier()) as? HomeEmptyStateCell else {
                return UITableViewCell()
            }
            
            cell.lblTitle.text = "Food Intake"
            cell.lblDescription.text = "Mulai lapar"
            cell.lblTitle.textColor = .blueGreen
            cell.icEmptyState.image = #imageLiteral(resourceName: "food")
            cell.icEmptyState.tintColor = .blueGreen

            return cell
        case MedicineTableCell.emptyStateidentifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyStateCell.cellIdentifier()) as? HomeEmptyStateCell else {
                return UITableViewCell()
            }
            
            cell.lblTitle.text = "Medicine Intake"
            cell.lblDescription.text = "You haven't taken a medicine today"
            cell.lblTitle.textColor = .purpleMedicine
            cell.icEmptyState.image = UIImage(systemName: "pills.fill")
            cell.icEmptyState.tintColor = .purpleMedicine

            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
