//
//  FoodIntakeViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class FoodIntakeViewController: UIViewController {

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

extension FoodIntakeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        identifiers.append(FoodCalIntakeChartCell.identifier)
        identifiers.append(FoodSugarIntakeChartCell.identifier)
        identifiers.append(FoodIntakeInfoCell.identifier)

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
        case FoodCalIntakeChartCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodCalIntakeChartCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        case FoodSugarIntakeChartCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodSugarIntakeChartCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            return cell
        default:            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}

