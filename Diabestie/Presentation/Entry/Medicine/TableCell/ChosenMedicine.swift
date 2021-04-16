//
//  ChosenMedicine.swift
//  Diabestie
//
//  Created by Revarino Putra on 06/04/21.
//

import UIKit

class ChosenMedicine: UITableViewCell {
    
    @IBOutlet weak var stepperValue: UILabel!
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var medicineTimes: UILabel!
    
    static let identifier = "medicineList"
    
    weak var delegate: MedicineEntryDelegate?
    var medicineLibrary: MedicineLibrary? {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //        let list: [MedicineLibrary] = MedicineLibraryRepository.shared.getMedicine(medicineName: medicineName.text!)
        //        medicineLibrary = list[0]
    }
    
    @IBAction func decrement(_ sender: UIButton) {
        if let medicineLibrary = medicineLibrary {
            
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
                delegate?.updateBasket(medicineLibrary: medicineLibrary, newValue: newValue)
            }
        }
    }
    
    @IBAction func increment(_ sender: UIButton) {
        if let medicineLibrary = medicineLibrary {
            if let value = Int(stepperValue.text ?? "1") {
                stepperValue.text = "\(value + 1)"
                delegate?.updateBasket(medicineLibrary: medicineLibrary, newValue: value+1)
            }
        }
    }
}
