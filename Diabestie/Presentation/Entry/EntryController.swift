//
//  EntryController.swift
//  Diabestie
//
//  Created by Julius Cesario on 06/04/21.
//

import UIKit
class EntryController: UIViewController {

    @IBOutlet weak var EntryCategoryView: UITableView!
    //data dummy
    let titleEntry = ["Blood Sugar", "Food", "Medicine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Entry Category"
        EntryCategoryView.dataSource = self
        EntryCategoryView.register(UINib(nibName: "EntryDataTableCell", bundle: nil), forCellReuseIdentifier: "EDataCell")
        // Do any additional setup after loading the view.
    }
}

extension EntryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleEntry.count
    }
    
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
    
    private func setBorder(_ dataCell:EntryDataTableCell  , _ left: CACornerMask, _ right: CACornerMask) -> Void {
        dataCell.clipsToBounds = true
        dataCell.layer.cornerRadius = 10
        dataCell.layer.maskedCorners = [left, right]
    }
}

