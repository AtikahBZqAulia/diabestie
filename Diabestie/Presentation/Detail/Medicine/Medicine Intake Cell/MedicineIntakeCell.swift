//
//  MedicineIntakeCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 07/04/21.
//

import UIKit

class MedicineIntakeCell: UITableViewCell {
    
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var timeLogLabel: UILabel!
    @IBOutlet weak var freqLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    static let identifier = "MedicineIntakeCell"
    
    var library: MedicineLibrary! {
        didSet {
            setupView()
        }
    }
    
    var medicineEntries: [MedicineEntries]? {
        return MedicineEntryRepository.shared.getMedicineEntryByDate(date: selectedDate)
        
    }
    
    var selectedDate = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        medNameLabel.text = library.medicine_name
        
        let consumption = library.consumption
        var times = 0
        var latestUpdate = Date()
        
        for entry in medicineEntries! {
            for basket in entry.medicinebasket! {
                let item = basket as! MedicineBasket
                if item.medicinelibrary!.medicine_name! == library.medicine_name! {
                    times += 1
                    latestUpdate = entry.time_log!
                    break
                }
            }
        }
        
        freqLabel.text = ("\(times)/\(consumption)")
        
        if consumption == 1 {
            unitLabel.text = "time"
        } else {
            unitLabel.text = "times"
        }
        
        if medicineEntries?.count != 0 {
            timeLogLabel.text = "Latest \(formatTo24HoursTime().string(from: latestUpdate))"
        } else {
            timeLogLabel.text = ""
        }
        
        
        
    }
    
    func formatTo24HoursTime() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH.mm"
        
        return formatter
    
    }

}
