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
            
            let bloodSugarData = BloodSugarEntryRepository.todaySugarLevelData()
            lblLatestBloodSugarLevel.text = "\(todayBloodSugarData.blood_sugar )"
            lblBloodSugarRange.text = bloodSugarData.range
            lblTime.text = todayBloodSugarData.time_log?.string(format: .HourMinutes)
                        
            if bloodSugarData.indicator == .none {
                if let indicatorView = viewBloodSugarIndicator {
                    indicatorView.removeFromSuperview()
                }
            } else {
                lblSugarLevelIndicator.text = Constants.BloodSugarLevelIndicator(indicator: bloodSugarData.indicator)
                lblSugarLevelIndicator.textColor = Constants.BloodSugarLevelIndicatorTxtColor(indicator: bloodSugarData.indicator)
                viewBgBloodSugarIndicator.backgroundColor = Constants.BloodSugarLevelIndicatorBGColor(indicator: bloodSugarData.indicator)
            }
        }
        
    }
    
}
