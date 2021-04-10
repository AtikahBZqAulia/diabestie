//
//  MedicineDiaryViewController.swift
//  Diabestie
//
//  Created by Revarino Putra on 04/04/21.
//

import UIKit

class MedicineDiaryViewController: UIViewController {

    @IBOutlet weak var medicineTableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var names: [String] = []
    var times: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicineTableView.dataSource = self
        medicineTableView.register(UINib(nibName: "EmptyTableCell", bundle: nil), forCellReuseIdentifier: "EmptyDataCell")
        
    }

    @IBAction func backToPreviousPage(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
   
}

extension MedicineDiaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = names.count
        if value != 0 {
            return value + 2
        }
        else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = medicineTableView.dequeueReusableCell(withIdentifier: "informationSection", for: indexPath)
            return cell
        }
        else if indexPath.row == 1 {
            let cell = medicineTableView.dequeueReusableCell(withIdentifier: "medicineButton", for: indexPath)
            return cell
        }
        
        else if indexPath.row > 1 && names.count != 0{
            if let cell = medicineTableView.dequeueReusableCell(withIdentifier: ChosenMedicine.identifier, for: indexPath) as? ChosenMedicine{
                cell.medicineName.text = names[indexPath.row - 2]
                cell.medicineTimes.text = "\(times[indexPath.row - 2]) times a day"
                if indexPath.row > 2 {addSeparator(cell)}
                return cell
            }
            
            else {
                return UITableViewCell()
            }
           
        }
        else {
            let cell = medicineTableView.dequeueReusableCell(withIdentifier: "EmptyDataCell") as! EmptyTableCell
            return cell
        }
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: medicineTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
}


