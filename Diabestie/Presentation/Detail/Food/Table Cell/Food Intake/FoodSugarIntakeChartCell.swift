//
//  FoodSugarIntakeChartCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 07/04/21.
//

import UIKit

class FoodSugarIntakeChartCell: UITableViewCell {

    static let identifier = "FoodSugarIntakeChartCell"

    @IBOutlet weak var viewRange: UIView!
    @IBOutlet weak var lblRange: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var barChart: BarChart!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
