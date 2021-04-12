//
//  BloodSugarChartCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 06/04/21.
//

import UIKit

class BloodSugarChartCell: UITableViewCell {
    
    static let identifier = "BloodSugarChartCell"
    
    @IBOutlet weak var viewRange: UIView!
    @IBOutlet weak var lblRange: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var barChart: BarChart!
    @IBOutlet weak var lblNutrition: UILabel!
    @IBOutlet weak var lblTextRange: UILabel!
    
    var bloogSugarDataRange: String? {
        didSet {
            setupData()
        }
    }
    
    var bloodSugarChartData: [BarDataEntry]? {
        didSet {
            setupChart()
        }
    }
    
    var chartThreshold: [BarChartThresholdDataEntry]? {
        didSet {
            setupChartThreshold()
        }
    }
    
    var todayDate: Date? {
        didSet {
            setupDateLabel()
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
    
    func setupDateLabel() {
        if let date = todayDate {
            lblDate.text = date.string(format: .DayMonth)
        }
    }
    
    func setupChartThreshold() {
        if let data = chartThreshold {
            barChart.initiateThreshold(thresholdDataEntry: data)
        }
    }
    
    func setupChart() {
        if let chartData = bloodSugarChartData {
            print("ASDDSA \(chartData)")
            barChart.updateDataEntries(dataEntries: chartData, animated: true)
        }
    }
    
    func setupData() {
        if let data = bloogSugarDataRange {
            if data != "0 - 0" {
                lblRange.text = data
                lblNutrition.isHidden = false
                lblTextRange.isHidden = false
            } else {
                lblRange.text = "No Data"
                lblNutrition.isHidden = true
                lblTextRange.isHidden = true
            }
        }
    }
    
}
