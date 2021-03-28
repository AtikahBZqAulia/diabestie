//
//  ViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 24/03/21.
//

import UIKit


class PrepareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addPrepare"){
            let tableVC = segue.destination as! TableViewController
        }
    }
    
}
