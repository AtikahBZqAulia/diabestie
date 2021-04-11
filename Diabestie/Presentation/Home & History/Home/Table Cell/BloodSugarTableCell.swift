//
//  BloodSugarTableCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import UIKit

class BloodSugarTableCell: UITableViewCell {

    static let identifier = "BloodSugarTableCell"
    static let emptyStateidentifier = "EmptyBloodSugarHistoryTableCell"
    
    @IBOutlet weak var lblSugarLevelIndicator: UILabel!
    @IBOutlet weak var viewBgBloodSugarIndicator: DesignableView!
    @IBOutlet weak var viewBloodSugarIndicator: UIView?
    @IBOutlet weak var lblLatestBloodSugarLevel: UILabel!
    @IBOutlet weak var lblBloodSugarRange: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblTime: UILabel!
    
    var bloodSugarEntry : BloodSugarEntries? {
        didSet {
            onDataSet()
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

    func onDataSet(){
        
        if let todayBloodSugarData = bloodSugarEntry {
            
            let bloodSugarDataRane = BloodSugarEntryRepository.sugarLevelRange()
            let bloodSugarDataIndicator = BloodSugarEntryRepository.shared.sugarLevelIndicator(bloodSugarEntry: todayBloodSugarData)
            lblLatestBloodSugarLevel.text = "\(todayBloodSugarData.blood_sugar )"
            lblBloodSugarRange.text = bloodSugarDataRane
            lblTime.text = todayBloodSugarData.time_log?.string(format: .HourMinutes)
                        
            if bloodSugarDataIndicator == .none {
                if let indicatorView = viewBloodSugarIndicator {
                    indicatorView.isHidden = true
                }
            } else {
                if let indicatorView = viewBloodSugarIndicator {
                    indicatorView.isHidden = false
                }
                lblSugarLevelIndicator.text = Constants.BloodSugarLevelIndicator(indicator: bloodSugarDataIndicator)
                lblSugarLevelIndicator.textColor = Constants.BloodSugarLevelIndicatorTxtColor(indicator: bloodSugarDataIndicator)
                viewBgBloodSugarIndicator.backgroundColor = Constants.BloodSugarLevelIndicatorBGColor(indicator: bloodSugarDataIndicator)
            }
        }
        
    }
    
}
