//
//  MedicineListCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 07/04/21.
//

import UIKit

class MedicineListCell: UITableViewCell {

    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var medicineTimes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
