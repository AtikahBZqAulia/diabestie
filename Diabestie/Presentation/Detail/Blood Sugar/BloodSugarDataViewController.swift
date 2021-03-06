//
//  BloodSugarDataViewController.swift
//  Diabestie
//
//  Created by Revarino Putra on 02/04/21.
//

import UIKit

class BloodSugarDataViewController: UIViewController {

    @IBOutlet weak var bloodDataView: UITableView!
    
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bloodDataView.dataSource = self
        bloodDataView.register(UINib(nibName: "BloodSugarDataTableCell", bundle: nil), forCellReuseIdentifier: "BSDataCell")
        bloodDataView.register(UINib(nibName: EmptyStateCellTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmptyStateCellTableViewCell.identifier)
        
    }
}

extension BloodSugarDataViewController {
    var bloodSugarData : [BloodSugarEntries]? {
        return BloodSugarEntryRepository.shared.getBloodSugarEntryByDate(date: selectedDate)
    }
}

extension BloodSugarDataViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 21, weight: .regular)
        header.textLabel?.textColor = .secondaryLabel
        header.textLabel?.text =  header.textLabel?.text?.capitalized
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Blood Sugar Entries"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !bloodSugarData!.isEmpty {
            return bloodSugarData?.count ?? 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !bloodSugarData!.isEmpty{
            if let dataCell = bloodDataView.dequeueReusableCell(withIdentifier: "BSDataCell", for: indexPath) as? BloodSugarDataTableCell {
                
                dataCell.bloodSugarData = bloodSugarData?[indexPath.row]
                
                return dataCell
            }
        }
        else {
            if let dataCell = bloodDataView.dequeueReusableCell(withIdentifier: EmptyStateCellTableViewCell.identifier, for: indexPath) as? EmptyStateCellTableViewCell {
                
                dataCell.lblDescription.text = "You don't have any entries yet"
                
                return dataCell
            }
        }
        return UITableViewCell()
    }
    
    
    private func setBorder(_ dataCell:BloodSugarDataTableCell  , _ left: CACornerMask, _ right: CACornerMask) -> Void {
        dataCell.clipsToBounds = true
        dataCell.layer.cornerRadius = 12
        dataCell.layer.maskedCorners = [left, right]
    }
}
