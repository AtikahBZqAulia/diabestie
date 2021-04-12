//
//  CallendarController.swift
//  Diabestie
//
//  Created by Julius Cesario on 07/04/21.
//

import UIKit

protocol CalendarControllerDelegate {
    func onDateSelected(date: Date)
}

class CalendarController: UIViewController {
    
    @IBOutlet weak var CalendarPicker: UIDatePicker!
    @IBOutlet weak var CancelAction: UIButton!
    
    var delegate:CalendarControllerDelegate?
    var selectedDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Date"
        CalendarPicker.preferredDatePickerStyle = .inline
        
        CalendarPicker.date = selectedDate
                
    }
    
    @IBAction func onDateChanged(_ sender: Any) {
        delegate?.onDateSelected(date: CalendarPicker.date)
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func CancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
