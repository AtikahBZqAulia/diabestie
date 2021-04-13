//
//  FoodTableCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import UIKit

class FoodTableCell: UITableViewCell {

    static let identifier = "FoodTableCell"
    static let emptyStateidentifier = "EmptyFoodHistoryTableCell"
    
    @IBOutlet weak var icChevron: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSugar: UILabel!
    @IBOutlet weak var lblCalories: UILabel!
    
    var isHistory: Bool = false

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

    func onDataSet(){
        if let data = foodEntry {
            
            if isHistory {
                icChevron.isHidden = true
            }
            
            let nutriton = FoodEntryRepository.shared.getFoodEntryNutrition(entry: data)
            lblSugar.text = "\(nutriton.sugar)"
            lblCalories.text = "\(nutriton.calorie)"
        }
    }
    
}
