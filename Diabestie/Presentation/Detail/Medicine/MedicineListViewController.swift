//
//  MedicineListViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class MedicineListViewController: UIViewController {
    
    @IBOutlet weak var medicineListTableView: UITableView!
    
    private var medicineList: [MedicineLibrary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicineList = MedicineLibraryRepository.shared.getAllMedicineLibrary()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.medicineList = MedicineLibraryRepository.shared.getAllMedicineLibrary()
        medicineListTableView.reloadData()
    }
    
}

extension MedicineListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineList.count + 1
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
                
                if medicineList[select].consumption == 1 {
                    stringTimes = "\(medicineList[select].consumption) time a day"
                }
                else {
                    stringTimes = "\(medicineList[select].consumption) times a day"
                }
                cell.medicineName.text = medicineList[select].medicine_name
                cell.medicineTimes.text = stringTimes
                if select != medicineList.count && select != 0 {
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
        let separatorView = UIView(frame: CGRect(x: 31, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
}
