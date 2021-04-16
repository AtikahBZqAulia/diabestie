//
//  FoodSugarIntakeChartCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 07/04/21.
//

import UIKit

class FoodSugarIntakeChartCell: UITableViewCell {

    static let identifier = "FoodSugarIntakeChartCell"

    @IBOutlet weak var viewRange: UIView!
    @IBOutlet weak var lblRange: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var barChart: BarChart!
    
    var sugarLevelData: [BarDataEntry]? {
        didSet {
            setupChart()
        }
    }
    
    var selectedDate: Date? {
        didSet {
            onDateSet()
        }
    }
    
    var totalCalorie : Int? {
        didSet {
            onTotalCalorieSet()
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

    
    func setupChart() {
        if let chartData = sugarLevelData {
            print("ASDDSA \(chartData)")
            barChart.updateDataEntries(dataEntries: chartData, animated: true)
        }
    }
    
    func onDateSet() {
        if let timeLog = selectedDate {
            lblDate.text = timeLog.string(format: .DayMonth)
        }
    }
    
    func onTotalCalorieSet() {
        if let calorie = totalCalorie {

            if calorie != 0 {
                lblRange.text = "\(calorie)"

            } else {
                lblRange.text = "No Data"
//                lblTextRange.isHidden = true
            }
        }
    }
}
