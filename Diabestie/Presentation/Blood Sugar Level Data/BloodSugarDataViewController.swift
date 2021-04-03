//
//  BloodSugarDataViewController.swift
//  Diabestie
//
//  Created by Revarino Putra on 02/04/21.
//

import UIKit

class BloodSugarDataViewController: UIViewController {

    @IBOutlet weak var bloodDataView: UITableView!
    
    //data dummy
    let after = ["After Dinner", "After Lunch", "After Breakfast"]
    let time = ["21.00", "14.00", "08.00"]
    let bloodLevel = [120, 60, 152]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bloodDataView.dataSource = self
        bloodDataView.register(UINib(nibName: "BloodSugarDataTableCell", bundle: nil), forCellReuseIdentifier: "BSDataCell")
        
    }
}

extension BloodSugarDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataCell = bloodDataView.dequeueReusableCell(withIdentifier: "BSDataCell", for: indexPath) as? BloodSugarDataTableCell {
            
            dataCell.eatName.text = after[indexPath.row]
            dataCell.eatTime.text = time[indexPath.row]
            dataCell.bloodLevel.text = String(bloodLevel[indexPath.row])
            
            switch indexPath.row {
            case 0:
                setBorder(dataCell , .layerMaxXMinYCorner, .layerMinXMinYCorner)
            case time.count - 1:
                setBorder(dataCell, .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            default:
                self.bloodDataView.layer.cornerRadius = 0
            }
            
            if bloodLevel[indexPath.row] < 100 {
                dataCell.iconStatus.image = UIImage(systemName: "arrow.down.circle")
                dataCell.iconStatus.tintColor = .tangerine
            }
            else if bloodLevel[indexPath.row] >= 100 && bloodLevel[indexPath.row] < 150 {
                dataCell.iconStatus.image = UIImage(systemName: "checkmark.circle")
            }
            else if bloodLevel[indexPath.row] >= 150 {
                dataCell.iconStatus.image = UIImage(systemName: "arrow.up.circle")
                dataCell.iconStatus.tintColor = .reddishPink
            }
            
            return dataCell
        }
        else {
            return UITableViewCell()
        }
    }
    
    private func setBorder(_ dataCell:BloodSugarDataTableCell  , _ left: CACornerMask, _ right: CACornerMask) -> Void {
        dataCell.clipsToBounds = true
        dataCell.layer.cornerRadius = 12
        dataCell.layer.maskedCorners = [left, right]
    }
}
