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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    var user: User! {
//        didSet{
//            setupView()
//        }
//    }
//
//
//    func setupView(){
//        boldLabel.text = "Name: \(user.name)"
//        lightLabel.text = "Address \(user.address)"
//
//        loadingIndicator.hidesWhenStopped = true
//        if user.isActive{
//            loadingIndicator.startAnimating()
//        }else{
//            loadingIndicator.stopAnimating()
//        }
//
//        switchView.isOn = user.isActive
//    }

}
