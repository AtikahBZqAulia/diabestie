//
//  CallendarController.swift
//  Diabestie
//
//  Created by Julius Cesario on 07/04/21.
//

import UIKit

class CalendarController: UIViewController {
    
    @IBOutlet weak var CalendarPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Date"
        CalendarPicker.preferredDatePickerStyle = .inline
    }
    
    
}
