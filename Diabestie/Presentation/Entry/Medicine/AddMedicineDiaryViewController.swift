//
//  AddMedicineDiaryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class AddMedicineDiaryViewController: UIViewController {
    
    @IBOutlet weak var addMedicineTableView: UITableView!
    
    private let names = ["Fortamet", "Glumetza", "Replaginide"]
    private let times = [1 , 3 , 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMedicineTableView.dataSource = self
        
    }

    @IBAction func backToPreviousModal(_ sender: UIBarButtonItem) {
        self.popBack(2)
    }
    
    private func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
}

extension AddMedicineDiaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = addMedicineTableView.dequeueReusableCell(withIdentifier: "createMedicine", for: indexPath)
            return cell
        }
        else {
            if let cell = addMedicineTableView.dequeueReusableCell(withIdentifier: "medicineList", for: indexPath) as? AddMedicineTableCell {
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
                if select != 0 && select != names.count {
                    addSeparator(cell)
                }
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
        
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: addMedicineTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
    
    
}
