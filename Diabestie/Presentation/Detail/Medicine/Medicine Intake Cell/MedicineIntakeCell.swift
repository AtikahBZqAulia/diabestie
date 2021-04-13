//
//  MedicineIntakeCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 07/04/21.
//

import UIKit

class MedicineIntakeCell: UITableViewCell {
    
    @IBOutlet weak var medName: UILabel!
    @IBOutlet weak var timeLog: UILabel!
    @IBOutlet weak var frequency: UILabel!

    static let identifier = "MedicineIntakeCell"
    
    var library: MedicineLibrary! {
        didSet {
            setupView()
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
    
    func setupView() {
        
    }

}
