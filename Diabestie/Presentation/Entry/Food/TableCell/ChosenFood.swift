//
//  ChosenFood.swift
//  Diabestie
//
//  Created by Wilson Adrilia on 07/04/2021.
//

import UIKit

class ChosenFood: UITableViewCell {
 
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodGram: UILabel!
    @IBOutlet weak var foodCal: UILabel!
    @IBOutlet weak var foodSugar: UILabel!
    @IBOutlet weak var stepperValue: UILabel!
    
    static let identifier = "foodList"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    weak var delegate: FoodEntryDelegate?
    
    var foodLibrary: FoodLibraries? {
        didSet {
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func decrement(_ sender: UIButton) {
        if let foodLibrary = foodLibrary {
            
            var newValue: Int = 0
            if let value = Int(stepperValue.text ?? "1") {
                newValue = value - 1
                if newValue > 0 {
                    stepperValue.text = "\(newValue)"
                    
                }
                else {
                    newValue = value
                    stepperValue.text = "\(newValue)"
                }
                delegate?.updateBasket(foodLibrary: foodLibrary, newValue: newValue)
            }
        }
    }
    
    @IBAction func increment(_ sender: UIButton) {
        if let foodLibrary = foodLibrary {
            if let value = Int(stepperValue.text ?? "1") {
                stepperValue.text = "\(value + 1)"
                delegate?.updateBasket(foodLibrary: foodLibrary, newValue: value+1)
            }
        }
    }

}
