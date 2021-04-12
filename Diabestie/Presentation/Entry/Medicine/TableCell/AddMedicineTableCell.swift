//
//  AddMedicineTableCell.swift
//  Diabestie
//
//  Created by Revarino Putra on 07/04/21.
//

import UIKit

class AddMedicineTableCell: UITableViewCell {

    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var medicineTimes: UILabel!
    @IBOutlet weak var stepperValue: UILabel!
    @IBOutlet weak var stepperView: DesignableView!
    @IBOutlet weak var addButtonView: DesignableView!
    
    weak var delegate: MedicineBasketDelegate?
    var medicineLibrary: MedicineLibrary!
    
    static let identifier = "medicineList"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepperView.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let list: [MedicineLibrary] = MedicineLibraryRepository.shared.getMedicine(medicineName: medicineName.text!)
        medicineLibrary = list[0]
    }

    @IBAction func increment(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            let newValue = value + 1
            stepperValue.text = "\(newValue)"
            delegate?.updateBasket(medicineLibrary: medicineLibrary, newValue: newValue)
        }
    }
    @IBAction func decrement(_ sender: UIButton) {
        if let value = Int(stepperValue.text ?? "1") {
            if value - 1 <= 0 {
                addButtonView.isHidden = false
                stepperView.isHidden = true
                delegate?.removeBasket(medicineLibrary: medicineLibrary)
            }
            else {
                let newValue = value - 1
                stepperValue.text = "\(newValue)"
                delegate?.updateBasket(medicineLibrary: medicineLibrary, newValue: newValue)
            }
        }
    }
    
    @IBAction func addMedicine(_ sender: UIButton) {
        addButtonView.isHidden = true
        stepperView.isHidden = false
        delegate?.addBasket(medicineLibrary: medicineLibrary, qty: 1)
    }
}
