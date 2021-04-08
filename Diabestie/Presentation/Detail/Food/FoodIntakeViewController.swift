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
    
    
    func generateRandomDataEntries() -> [DataEntry] {
        let numEntry = 3
        
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [DataEntry] = []
        for i in 0..<numEntry {
            let value = (arc4random() % 90) + 100
            let randomTime = Float.random(in: 1..<24)
            result.append(DataEntry(color: colors[i % colors.count], height: Float(value), textValue: "\(value)", title: "\(randomTime)",time: Float(randomTime)))
        }
        return result
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
            
            let dataEntries = generateRandomDataEntries()
            cell.barChart.updateDataEntries(dataEntries: dataEntries, animated: true)

            
            cell.selectionStyle = .none
            
            return cell
        case FoodSugarIntakeChartCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodSugarIntakeChartCell else {
                return UITableViewCell()
            }
            
            let dataEntries = generateRandomDataEntries()
            cell.barChart.updateDataEntries(dataEntries: dataEntries, animated: true)

            
            cell.selectionStyle = .none
            
            return cell
        default:            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}

