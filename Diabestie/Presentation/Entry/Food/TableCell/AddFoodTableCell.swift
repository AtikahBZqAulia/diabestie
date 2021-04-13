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
    
    weak var delegate: FoodBasketDelegate?
    var foodLibrary: FoodLibraries!
    
    static let identifier = "foodList"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepperView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let list: [FoodLibraries] =
            FoodLibraryRepository.shared.getFood(foodName: foodName.text ?? "")
        
        if !list.isEmpty {
            foodLibrary = list.first
        }
    }
    
    
    @IBAction func increment2(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            let newValue = value + 1
            stepperValue.text = "\(value + 1)"
            delegate?.updateBasket(foodLibrary: foodLibrary, newValue: newValue)
        }
    }

    @IBAction func decrement2(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            if value - 1 <= 0 {
                addButtonView.isHidden = false
                stepperView.isHidden = true
                delegate?.removeBasket(foodLibrary: foodLibrary)
            }
            else {
                let newValue = value - 1
                stepperValue.text = "\(value - 1)"
                delegate?.updateBasket(foodLibrary: foodLibrary, newValue: newValue)
            }
        }
    }
    
    @IBAction func addFood(_ sender: UIButton) {
        addButtonView.isHidden = true
        stepperView.isHidden = false
        delegate?.addBasket(foodLibrary: foodLibrary, qty: 1)
    }
    
}
