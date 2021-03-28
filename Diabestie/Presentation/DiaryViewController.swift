//
//  ViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 24/03/21.
//

import UIKit


class DiaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addFood"){
            let tableVC = segue.destination as! TableViewController
            tableVC.delegate = self
            tableVC.titleName = "Add Food"
        }
    }
    
}

extension DiaryViewController : TableViewControllerDelegate {
    
    func doSomethingWith(data: String) {
        print("DO SOMETING WITH IT \(data)")
    }
    
}
