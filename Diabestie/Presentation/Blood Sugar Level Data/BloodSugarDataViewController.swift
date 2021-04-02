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
    var after = ["After Dinner", "After Lunch", "After Breakfast"]
    var time = ["21.00", "14.00", "08.00"]
    var bloodLevel = [120, 60, 152]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bloodDataView.dataSource = self
        bloodDataView.register(UINib(nibName: "BloodSugarDataTableCell", bundle: nil), forCellReuseIdentifier: "BSDataCell")
        bloodDataView.layer.cornerRadius = 12
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
}
