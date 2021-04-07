//
//  EntrySugarDataTableCell.swift
//  Diabestie
//
//  Created by Julius Cesario on 06/04/21.
//

import UIKit
class EntryDataTableCell: UITableViewCell {
    @IBOutlet weak var logoEntry: UIImageView!
    @IBOutlet weak var logoBoxEntry: UIView!
    @IBOutlet weak var titleEntry: UILabel!
    @IBOutlet weak var chevronEntry: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
