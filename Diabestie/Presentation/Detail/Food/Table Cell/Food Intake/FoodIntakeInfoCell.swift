//
//  FoodIntakeInfoCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 07/04/21.
//

import UIKit

class FoodIntakeInfoCell: UITableViewCell {

    static let identifier = "FoodIntakeInfoCell"

    @IBOutlet weak var lblSugar: UILabel!
    @IBOutlet weak var lblCalorie: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var foodEntry : FoodEntries? {
        didSet {
            onDataSet()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func onDataSet() {
        if let entry = foodEntry {
            let nutrition = FoodEntryRepository.shared.getFoodEntryTotalNutrition(entry: entry)
            lblSugar.text = "\(nutrition.sugar)"
            lblCalorie.text = "\(nutrition.calorie)"
            lblTime.text = "Latest: \(entry.time_log?.string(format: .HourMinutes) ?? "")"
        }
    }
}
