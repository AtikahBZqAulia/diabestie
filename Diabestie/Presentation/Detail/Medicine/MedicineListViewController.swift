//
//  MedicineListViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class MedicineListViewController: UIViewController {
    
    
    private let names = ["Fortamet", "Glumetza", "Replaginide"]
    private let times = [1 , 3 , 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension MedicineListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "createMedicine", for: indexPath)
            return cell
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MedicineListCell.cellIdentifier(), for: indexPath) as? MedicineListCell {
                let select: Int = indexPath.row - 1
                
                var stringTimes: String!
                if times[select] == 1 {
                    stringTimes = "\(times[select]) time a day"
                }
                else {
                    stringTimes = "\(times[select]) times a day"
                }
                cell.medicineName.text = names[select]
                cell.medicineTimes.text = stringTimes
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
        
        
    }
}
