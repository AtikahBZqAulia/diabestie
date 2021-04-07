//
//  MedicineIntakeDataViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class MedicineIntakeDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MedicineIntakeDataViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        header.textLabel?.textColor = .charcoalGrey
        header.textLabel?.text =  header.textLabel?.text?.capitalized

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Medicine Entries".uppercased()
    }
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        identifiers.append(MedicineIntakeDataCell.identifier)
        identifiers.append(MedicineIntakeDataCell.identifier)
        identifiers.append(MedicineIntakeDataCell.identifier)
        identifiers.append(MedicineIntakeDataCell.identifier)

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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        
        switch identifier {
        case MedicineIntakeDataCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MedicineIntakeDataCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}

