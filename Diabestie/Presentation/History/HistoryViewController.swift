//
//  HistoryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var viewCalendar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.backgr
//        self.navigationController?.navigationItem.hidesBackButton = true
//        self.navigationController?.navigationBar.barStyle = .default

        self.navigationController?.navigationBar.tintColor  = .white

        
        
        //        let calendar = HorizontalCalendar()
        //
        //        view.addSubview(calendar)
        //        calendar.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
        //            calendar.leftAnchor.constraint(equalTo: view.leftAnchor),
        //            calendar.rightAnchor.constraint(equalTo: view.rightAnchor)
        //        ])
        //
        //
        //
        //        calendar.onSelectionChanged = { date in
        //            print(date)
        //        }
        
    }
    
}
