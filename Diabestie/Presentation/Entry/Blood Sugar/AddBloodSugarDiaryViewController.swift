//
//  AddBloodSugarDiaryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class AddBloodSugarDiaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension AddBloodSugarDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableViewIdentifier() -> [String] {
        var identifiers = [String]()
        
        identifiers.append(AddBloodSugarCategoryTableCell.identifier)
        identifiers.append(AddBloodSugarTableCell.identifier)
        
        return identifiers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewIdentifier().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = self.tableViewIdentifier()[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }
        
        switch identifier {
        case AddBloodSugarCategoryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddBloodSugarCategoryTableCell else {
                return UITableViewCell()
            }
            return cell
            
        case AddBloodSugarTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddBloodSugarTableCell else {
                return UITableViewCell()
            }
            addSeparator(cell, tableView: tableView)
            return cell
            
        default:
            return cell
        }
    }
    
    private func addSeparator(_ cell: UITableViewCell, tableView: UITableView) -> Void {
        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
    
}
