//
//  MedicineIntakeDataCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 07/04/21.
//

import UIKit

class MedicineIntakeDataCell: UITableViewCell {
    
    @IBOutlet weak var medCategoryLabel: UILabel!
    @IBOutlet weak var timeLogLabel: UILabel!
    
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var medNameLabel2: UILabel!
    @IBOutlet weak var medNameLabel3: UILabel!
    
    @IBOutlet weak var medQtyLabel: UILabel!
    @IBOutlet weak var medQtyLabel2: UILabel!
    @IBOutlet weak var medQtyLabel3: UILabel!
    
    @IBOutlet weak var medUnitLabel: UILabel!
    @IBOutlet weak var medUnitLabel2: UILabel!
    @IBOutlet weak var medUnitLabel3: UILabel!
    
    @IBOutlet weak var firstVerSeparator: UIView!
    @IBOutlet weak var secondVerSeparator: UIView!

    static let identifier = "MedicineIntakeDataCell"
    
    var medBaskets: [MedicineBasket]?
    var medLabels: [UILabel]!
    var medQtys: [UILabel]!
    var medUnit: [UILabel]!
    var separators: [UIView]!
    
    var entry: MedicineEntries! {
        didSet {
            setupView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        firstVerSeparator.isHidden = true
        secondVerSeparator.isHidden = true
        
        medLabels =  [medNameLabel, medNameLabel2, medNameLabel3]
        medQtys = [medQtyLabel, medQtyLabel2, medQtyLabel3]
        medUnit = [medUnitLabel, medUnitLabel2, medUnitLabel3]
        separators = [firstVerSeparator, secondVerSeparator]
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView() {

        medCategoryLabel.text = Constants.medCategoryList[Int(entry.category)]
        timeLogLabel.text = formatTo24HoursTime().string(from: entry.time_log!)
        
        for (i,value) in entry.medicinebasket!.enumerated() {
            let basket = value as! MedicineBasket
            if i <= 3 {
                medLabels[i].text = String(basket.medicinelibrary!.medicine_name!)
                medQtys[i].text = String(basket.qty)
                if basket.qty == 1 {
                    medUnit[i].text = "pill"
                } else {
                    medUnit[i].text = "pills"
                }

                if i < entry.medicinebasket!.count - 1 {
                    separators[i].isHidden = false
                }
            } else {
                break
            }
        }
        
    }
    
    func formatTo24HoursTime() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter
    
    }

}
