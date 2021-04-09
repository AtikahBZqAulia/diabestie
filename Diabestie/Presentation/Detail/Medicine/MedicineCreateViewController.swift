//
//  MedicineCreateViewController.swift
//  Diabestie
//
//  Created by Revarino Putra on 08/04/21.
//

import UIKit

class MedicineCreateViewController: UITableViewController {

    @IBOutlet var createMedicineView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func viewIdentifier() -> [String] {
        var identifiers = [String]()
        identifiers.append("InformationCell")
        identifiers.append(InputMedicineNameTableCell.identifier)
        identifiers.append(MedicineFrequencyTableCell.identifier)
        
        return identifiers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = viewIdentifier()[indexPath.row]
        let cell = createMedicineView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if indexPath.row == 2 {
            addSeparator(cell)
        }
        return cell
    }


    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: createMedicineView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
    
}
