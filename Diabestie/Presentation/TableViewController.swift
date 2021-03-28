//
//  TableViewController.swift
//  IOSAddSearchTableViewTutorial
//
//  Created by Arthur Knopper on 13/12/2018.
//  Copyright © 2018 Arthur Knopper. All rights reserved.
//
import UIKit

protocol TableViewControllerDelegate : NSObjectProtocol {
    func doSomethingWith(data: String)
}


class TableViewController: UITableViewController, UISearchResultsUpdating {
    let tableData = ["One", "Two", "Three","Twenty-One"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var titleName = ""
    
    /// pop back n viewcontroller
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }

    weak var delegate : TableViewControllerDelegate?
 
    @IBAction func onCancel(segue: UIStoryboardSegue) {
        
        if let delegate = delegate{
            delegate.doSomethingWith(data: "John Cena")
            self.popBack(3)
//            self.navigationController?.popViewController(animated: true)
            
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
 
 
    override func viewDidLoad() {
        super.viewDidLoad()

        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.title = titleName
        
        // Reload the table
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableData.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (resultSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = tableData[indexPath.row]
            print(tableData[indexPath.row])
            return cell
        }
    }
    
}
