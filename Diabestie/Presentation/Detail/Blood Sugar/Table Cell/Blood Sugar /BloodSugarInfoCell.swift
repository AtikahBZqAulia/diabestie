//
//  BloodSugarThresholdCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 06/04/21.
//

import UIKit

class BloodSugarInfoCell: UITableViewCell {
    
    static let identifier = "BloodSugarInfoCell"
    @IBOutlet weak var lblSugarLevelIndicator: UILabel!
    @IBOutlet weak var viewBloodSugarIndicator: UIView!
    @IBOutlet weak var viewBgBloodSugarIndicator: DesignableView!
    @IBOutlet weak var icStableCheck: UIImageView!
    @IBOutlet weak var lblLatestBloodSugarLevel: UILabel!
    @IBOutlet weak var lblLatestTime: UILabel!
    
    var bloodSugarIndicator : Constants.BloodSugarLevelIndicatorCode? {
        didSet {
            setupInfo()
        }
    }
    
    var bloodSugarLatestEntryTime: Date? {
        didSet {
            setupBloodSugarLatestEntry()
        }
    }
    
    var bloodSugarLatestValue: Int? {
        didSet {
            setupBloodSugarLatestValue()
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
    
    func setupBloodSugarLatestEntry(){
        lblLatestTime.text = "Latest : \(bloodSugarLatestEntryTime?.string(format: .HourMinutes) ?? "")"
    }
    
    func setupBloodSugarLatestValue(){
        lblLatestBloodSugarLevel.text = "\(bloodSugarLatestValue ?? 0)"
    }
    
    func setupInfo(){
        if let data = bloodSugarIndicator{
            
            print("ASDASD \(data)")
            
            if data == .stable {
                icStableCheck.isHidden = false
            } else {
                icStableCheck.isHidden = true
            }
            
            if data != .none {
                lblSugarLevelIndicator.text = Constants.BloodSugarLevelIndicator(indicator: data)
                lblSugarLevelIndicator.textColor = Constants.BloodSugarLevelIndicatorTxtColor(indicator: data)
                viewBgBloodSugarIndicator.backgroundColor = Constants.BloodSugarLevelIndicatorBGColor(indicator: data)
                viewBloodSugarIndicator.isHidden = false
            } else {
                viewBloodSugarIndicator.isHidden = true
            }
        }
    }
    
}
