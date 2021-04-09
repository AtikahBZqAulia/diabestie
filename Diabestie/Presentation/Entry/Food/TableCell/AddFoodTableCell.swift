//
//  AddFoodTableCell.swift
//  Diabestie
//
//  Created by Wilson Adrilia on 08/04/2021.
//

import UIKit

class AddFoodTableCell: UITableViewCell{

    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodGram: UILabel!
    @IBOutlet weak var foodCal: UILabel!
    @IBOutlet weak var foodSugar: UILabel!
    @IBOutlet weak var stepperValue: UILabel!
    @IBOutlet weak var stepperView: DesignableView!
    @IBOutlet weak var addButtonView: DesignableView!
    
    var foods : Foods? {
        didSet {
            if foods != nil {
//                self.foodName.text = "\(foods.foodname)"
//                self.foodGram.text = "\(foods.grams) g"
//                self.foodCal.text = "\(foods.cal) kcal"
//                self.foodSugar.text = "\(foods.sugar) mg sugar"
            }
        }
    }
    
    static let identifier = "foodList"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepperView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func increment2(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            stepperValue.text = "\(value + 1)"
        }
    }

    @IBAction func decrement2(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            if value - 1 <= 0 {
                addButtonView.isHidden = false
                stepperView.isHidden = true
            }
            else {
                stepperValue.text = "\(value - 1)"
            }
        }
    }
    
    @IBAction func addFood(_ sender: UIButton) {
        addButtonView.isHidden = true
        stepperView.isHidden = false
    }
    
}
