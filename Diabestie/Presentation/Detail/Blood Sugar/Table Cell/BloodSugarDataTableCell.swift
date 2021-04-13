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
    
    var bloodSugarData: BloodSugarEntries? {
        didSet {
            setupData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupData() {
        if let data = bloodSugarData {
            self.eatName.text = Constants.bloodSgrCategoryList[Int(data.category)]
            self.bloodLevel.text = "\(Int(data.blood_sugar))"
            self.eatTime.text = data.time_log?.string(format: .HourMinutes)
            
            let indicator = BloodSugarEntryRepository.shared.sugarLevelIndicator(bloodSugarEntry: bloodSugarData)
            
            switch(indicator) {
            case .high :
                iconStatus.image = UIImage(systemName: "arrow.up.circle")
                iconStatus.tintColor = .reddishPink
            case .low :
                iconStatus.image = UIImage(systemName: "arrow.down.circle")
                iconStatus.tintColor = .tangerine
            case .none :
                iconStatus.image = UIImage(systemName: "checkmark.circle")
                iconStatus.tintColor = .greenLight
            case .stable :
                iconStatus.image = UIImage(systemName: "checkmark.circle")
                iconStatus.tintColor = .greenLight
            }
        }
    }
    
}
