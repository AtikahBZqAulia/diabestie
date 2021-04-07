//
//  EntryController.swift
//  Diabestie
//
//  Created by Julius Cesario on 06/04/21.
//

import UIKit
class EntryController: UIViewController {

    @IBOutlet weak var EntryCategoryView: UITableView!
    @IBOutlet weak var CancelAction: UIBarButtonItem!
    //data entry
    let titleEntry = ["Blood Sugar", "Food", "Medicine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Entry Category"
        EntryCategoryView.dataSource = self
        EntryCategoryView.delegate = self
        EntryCategoryView.register(UINib(nibName: "EntryDataTableCell", bundle: nil), forCellReuseIdentifier: "EDataCell")
        
        /**CANCEL BUTTON NOT USED
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backAction))**/
    }
    
 
    @IBAction func CancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension EntryController: UITableViewDataSource, UITableViewDelegate {
    //DECLEARE FUNCTION FOR NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleEntry.count
    }
    
    //DECLARE FUNCTION FOR GENERATE VIEW OF TABLE CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataCell = EntryCategoryView.dequeueReusableCell(withIdentifier: "EDataCell", for: indexPath) as? EntryDataTableCell {
            
            dataCell.titleEntry.text =  titleEntry[indexPath.row]
            dataCell.chevronEntry.image = UIImage(systemName :"chevron.right")
            switch indexPath.row {
            case 0:
                dataCell.logoEntry.image = UIImage(systemName :"drop.fill")
                dataCell.logoBoxEntry.backgroundColor = #colorLiteral(red: 1, green: 0.04984947294, blue: 0.09696806222, alpha: 1)
                setBorder(dataCell , .layerMaxXMinYCorner, .layerMinXMinYCorner)
            case titleEntry.count - 1:
                dataCell.logoEntry.image = UIImage(systemName :"pills.fill")
                dataCell.logoBoxEntry.backgroundColor = #colorLiteral(red: 0.4002308846, green: 0.2648269534, blue: 0.8177123666, alpha: 1)
                setBorder(dataCell, .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            default:
                dataCell.logoEntry.image = #imageLiteral(resourceName: "food")
                dataCell.logoBoxEntry.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.431372549, blue: 0.3215686275, alpha: 1)
                self.EntryCategoryView.layer.cornerRadius = 0
            }
            dataCell.logoEntry.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            return dataCell
        }
        else {
            return UITableViewCell()
        }
    }
    
    //DECLEARE FUNCTION FOR SELECT ON ROW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyboardFood = UIStoryboard.init(name: "FoodEntry", bundle: nil)
        let storyboardMedicine = UIStoryboard.init(name: "MedicineEntry", bundle: nil)
        let storyboardBloodSugar = UIStoryboard.init(name: "BloodSugarEntry", bundle: nil)
        switch indexPath.row {
            case 0:
                let viewBloodSugarEntry = storyboardBloodSugar.instantiateViewController(identifier: "AddBloodSugarDiaryViewController")
                self.navigationController?.pushViewController(viewBloodSugarEntry, animated: true)
            case titleEntry.count - 1:
                let viewMedicineEntry = storyboardMedicine.instantiateViewController(identifier: "AddMedicineDiaryViewController")
                self.navigationController?.pushViewController(viewMedicineEntry, animated: true)
            default:
                let viewFoodEntry = storyboardFood.instantiateViewController(identifier: "AddFoodDiaryViewController")
                self.navigationController?.pushViewController(viewFoodEntry, animated: true)
        }
    }
    //DECLEARE FUNCTION FOR DATA CELL
    private func setBorder(_ dataCell:EntryDataTableCell  , _ left: CACornerMask, _ right: CACornerMask) -> Void {
        dataCell.clipsToBounds = true
        dataCell.layer.cornerRadius = 10
        dataCell.layer.maskedCorners = [left, right]
    }
}

