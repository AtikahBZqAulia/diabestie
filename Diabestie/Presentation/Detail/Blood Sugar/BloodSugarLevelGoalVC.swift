//
//  BloodSugarLevelGoalVC.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class BloodSugarLevelGoalVC: UITableViewController {

    @IBOutlet weak var edtFastingUpperBound: UITextField!
    @IBOutlet weak var edtFastingLowerBound: UITextField!
    @IBOutlet weak var edtMealUpperBound: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

//        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//
//        header.textLabel?.font = .systemFont(ofSize: 14, weight: .regular)
//        header.textLabel?.textColor = .charcoalGrey
//        header.textLabel?.text =  header.textLabel?.text
//
//
//        header.backgroundView =  UIView(frame: header.bounds)
//        header.backgroundView?.backgroundColor = .grayBackground

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame

        let title = UILabel()
        title.frame =  CGRect(x: 16, y: 20, width: headerFrame.size.width-20, height: 20) //width equals to parent view with 10 left and right margin
        title.font = title.font.withSize(14)
        title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
        title.textColor = .charcoalGrey

        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.addSubview(title)

        return headerView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
