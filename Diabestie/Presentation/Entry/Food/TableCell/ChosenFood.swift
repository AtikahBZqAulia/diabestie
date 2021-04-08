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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

    @IBAction func decrement(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            stepperValue.text = "\(value - 1)"
        }
    }
    
    @IBAction func increment(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            stepperValue.text = "\(value + 1)"
        }
    }
}

