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
    @IBOutlet weak var lblTitleCalories: UILabel!
    @IBOutlet weak var lblTitleSugar: UILabel!
    
    var isHistory: Bool = false

    var foodEntry : [FoodEntries]? {
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
    
    func onDataSetEmptyState() {
        lblTitleSugar.text = "Total Sugar"
        lblTitleCalories.text = "Total Cal"
        lblSugar.text = "0"
        lblCalories.text = "0"
        lblTime.text = ""
    }

    func onDataSet(){
        if let data = foodEntry {
            
            if isHistory {
                icChevron.isHidden = true
                let latestFood = foodEntry?.last
                let nutrition = FoodEntryRepository.shared.getFoodEntryTotalNutrition(entry: latestFood)
                lblSugar.text = "\(nutrition.sugar)"
                lblCalories.text = "\(nutrition.calorie)"
            }
            
            var totalSugar = 0
            var totalCalories = 0
            for food in data {
                let nutrition = FoodEntryRepository.shared.getFoodEntryTotalNutrition(entry: food)
                totalSugar += nutrition.sugar
                totalCalories += nutrition.calorie
            }
            
            lblSugar.text = "\(totalSugar)"
            lblCalories.text = "\(totalCalories)"
                
        }
    }
    
}
