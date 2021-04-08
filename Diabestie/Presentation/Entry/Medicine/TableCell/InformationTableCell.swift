//
//  InformationTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 08/04/21.
//

import UIKit

class InformationTableCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.tintColor = #colorLiteral(red: 0.1294117647, green: 0.2901960784, blue: 0.7803921569, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
