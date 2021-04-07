//
//  CallendarController.swift
//  Diabestie
//
//  Created by Julius Cesario on 07/04/21.
//

import UIKit

class CalendarController: UIViewController {
    
    @IBOutlet weak var CalendarPicker: UIDatePicker!
    @IBOutlet weak var CancelAction: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Date"
        CalendarPicker.preferredDatePickerStyle = .inline
    }
    @IBAction func CancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
