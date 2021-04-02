//
//  BloodSugarDataTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 02/04/21.
//

import UIKit

class BloodSugarDataTableCell: UITableViewCell {

    @IBOutlet weak var eatName: UILabel!
    @IBOutlet weak var eatTime: UILabel!
    @IBOutlet weak var bloodLevel: UILabel!
    @IBOutlet weak var iconStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
