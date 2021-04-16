//
//  FoodIntakeDataCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 13/04/21.
//

import UIKit

class FoodIntakeDataCell: UITableViewCell {
    
    @IBOutlet weak var eatTime: UILabel!
    @IBOutlet weak var timeLog: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
