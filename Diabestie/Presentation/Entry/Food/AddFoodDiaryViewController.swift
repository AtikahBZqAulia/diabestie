//
//  AddFoodDiaryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class AddFoodDiaryViewController: UIViewController {

    @IBOutlet weak var foodEntryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodEntryTableView.register(UINib(nibName: "EmptyTableCell", bundle: nil), forCellReuseIdentifier: "EmptyDataCell")
        // Do any additional setup after loading the view.
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
