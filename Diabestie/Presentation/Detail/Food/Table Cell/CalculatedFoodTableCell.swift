//
//  CalculatedFoodTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 04/04/21.
//

import UIKit

class CalculatedFoodTableCell: UITableViewCell {

    static let identifier = "calculatedCell"
    
    @IBOutlet weak var eatName: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var sugar: UILabel!
    @IBOutlet weak var eatTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
