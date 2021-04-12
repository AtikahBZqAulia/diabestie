//
//  MedicineIntakeViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class MedicineIntakeViewController: UIViewController {
    
    //var users: [User] = User.generateDummyData()
    
    
    @IBOutlet weak var viewCalendar: ExtendedNavBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage.transparentPixel
        
        let calendar = HorizontalCalendar()
        
        viewCalendar.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: viewCalendar.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leftAnchor.constraint(equalTo: viewCalendar.leftAnchor),
            calendar.rightAnchor.constraint(equalTo: viewCalendar.rightAnchor)
        ])
        
    }
}

extension MedicineIntakeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        //medicine library.count
        identifiers.append(MedicineIntakeCell.identifier)
        identifiers.append(MedicineIntakeCell.identifier)
        identifiers.append(MedicineIntakeCell.identifier)
        identifiers.append(MedicineIntakeInfoCell.identifier)
        identifiers.append(MedicineIntakeOptionCell.identifier)
        
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
        case MedicineIntakeCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MedicineIntakeCell else {
                return UITableViewCell()
            }
            //cell.user = users[indexPath.row]
            cell.selectionStyle = .none
            
            return cell
        default:
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
