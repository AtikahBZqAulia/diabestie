//
//  InformationTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 08/04/21.
//

import UIKit

class InformationTableCell: UITableViewCell {
    
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    static let identifier = "informationSection"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
