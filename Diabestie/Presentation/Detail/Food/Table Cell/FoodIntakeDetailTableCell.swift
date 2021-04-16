//
//  FoodIntakeDetailTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 03/04/21.
//

import UIKit

class FoodIntakeDetailTableCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodGram: UILabel!
    @IBOutlet weak var foodCal: UILabel!
    @IBOutlet weak var foodSugar: UILabel!
    @IBOutlet weak var foodListView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
