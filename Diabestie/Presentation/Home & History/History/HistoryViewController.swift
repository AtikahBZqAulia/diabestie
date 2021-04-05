//
//  HistoryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var viewCalendar: ExtendedNavBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage.transparentPixel
        //        self.navigationController?.navigationBar.barTintColor = .purple
        //        self.navigationController?.navigationBar.tintColor = .blueBlue
        
        let calendar = HorizontalCalendar()
        
        viewCalendar.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: viewCalendar.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leftAnchor.constraint(equalTo: viewCalendar.leftAnchor),
            calendar.rightAnchor.constraint(equalTo: viewCalendar.rightAnchor)
        ])
        
        //        calendar.onSelectionChanged = { date in
        //            print(date)
        //        }
        
    }
    
}

extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        header.textLabel?.textColor = .black
        header.textLabel?.text =  header.textLabel?.text?.capitalized

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Today, 6 April"
    }
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
//        identifiers.append(AddDiaryTableCell.identifier)
        identifiers.append(BloodSugarTableCell.identifier)
        identifiers.append(FoodTableCell.identifier)
        identifiers.append(MedicineTableCell.identifier)
        identifiers.append(DiaryHistoryTableCell.identifier)

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
        case AddDiaryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddDiaryTableCell else {
                return UITableViewCell()
            }
            return cell
        case BloodSugarTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BloodSugarTableCell else {
                return UITableViewCell()
            }
            return cell
        case FoodTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodTableCell else {
                return UITableViewCell()
            }
            return cell
        case MedicineTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MedicineTableCell else {
                return UITableViewCell()
            }
            return cell
        case DiaryHistoryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DiaryHistoryTableCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return cell
        }
    }
    
    
}

