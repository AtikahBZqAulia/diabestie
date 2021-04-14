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
    
    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var lblHistory: UILabel!
    @IBOutlet weak var viewRange: UIView!
    @IBOutlet weak var viewLatest: UIView!
    @IBOutlet weak var icChevron: UIImageView!
    @IBOutlet weak var lblSugarLevelIndicator: UILabel!
    @IBOutlet weak var viewBgBloodSugarIndicator: DesignableView!
    @IBOutlet weak var viewBloodSugarIndicator: UIView?
    @IBOutlet weak var lblLatestBloodSugarLevel: UILabel!
    @IBOutlet weak var lblBloodSugarRange: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblTime: UILabel!
    
    var isHistory: Bool = false
    
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
    
    func onDataSetEmptyState() {
        lblLatestBloodSugarLevel.text = "--"
        lblBloodSugarRange.text = "--"
        viewHistory.isHidden = true
        lblTime.text = ""
        viewBgBloodSugarIndicator.isHidden = true
        
    }

    func onDataSet(){
        
        if let todayBloodSugarData = bloodSugarEntry {
            
            if !isHistory {

                viewHistory.isHidden = true

                let bloodSugarDataRange = BloodSugarEntryRepository.sugarLevelRange()
                let bloodSugarDataIndicator = BloodSugarEntryRepository.shared.sugarLevelIndicator(bloodSugarEntry: todayBloodSugarData)
                lblLatestBloodSugarLevel.text = "\(todayBloodSugarData.blood_sugar)"
                lblBloodSugarRange.text = bloodSugarDataRange
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
                
            } else {
                lblHistory.text = "\(todayBloodSugarData.blood_sugar )"
                lblTime.text = todayBloodSugarData.time_log?.string(format: .HourMinutes)
                viewHistory.isHidden = false
                if let viewLatest = viewLatest {
                    viewLatest.removeFromSuperview()
                }
                if let viewRange = viewRange {
                    viewRange.removeFromSuperview()
                }
                //icChevron.isHidden = true
                
                let bloodSugarDataIndicator = BloodSugarEntryRepository.shared.sugarLevelIndicator(bloodSugarEntry: todayBloodSugarData)
                
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
    
}
