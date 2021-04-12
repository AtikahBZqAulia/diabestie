//
//  AddMedicineDiaryViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit


protocol MedicineBasketDelegate: class {
    func addBasket(medicineLibrary: MedicineLibrary, qty: Int)
    func removeBasket(medicineLibrary: MedicineLibrary)
    func updateBasket(medicineLibrary: MedicineLibrary, newValue: Int)
}

class AddMedicineDiaryViewController: UIViewController {
    
    @IBOutlet weak var addMedicineTableView: UITableView!
    
    var medicineList: [MedicineLibrary] = []
    var baskets: [MedicineBasket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicineList = MedicineLibraryRepository.shared.getAllMedicineLibrary()
        
        addMedicineTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "CreateMedicine" {
            let destVC = segue.destination as! MedicineDiaryViewController
            destVC.medicineBasket = baskets
        }
    }
    
    
}

extension AddMedicineDiaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = addMedicineTableView.dequeueReusableCell(withIdentifier: "createMedicine", for: indexPath)
            return cell
        }
        else {
            if let cell = addMedicineTableView.dequeueReusableCell(withIdentifier: "medicineList", for: indexPath) as? AddMedicineTableCell {
                let select: Int = indexPath.row - 1
                cell.delegate = self
                var stringTimes: String!
                if medicineList[select].consumption == 1 {
                    stringTimes = "\(medicineList[select].consumption) time a day"
                }
                else {
                    stringTimes = "\(medicineList[select].consumption) times a day"
                }
                cell.medicineName.text = medicineList[select].medicine_name
                cell.medicineTimes.text = stringTimes
                    if !self.baskets.isEmpty {
                        if let data = self.baskets.first(where: {
                            cell.medicineName.text == $0.medicinelibrary?.medicine_name
                        }) {
                            cell.addButtonView.isHidden = true
                            cell.stepperView.isHidden = false
                            cell.stepperValue.text = "\(data.qty)"
                        }
                        
                    }
                
                if select != 0 && select != medicineList.count {
                    addSeparator(cell)
                }
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
        
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: addMedicineTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
}

extension AddMedicineDiaryViewController: MedicineBasketDelegate {
    func updateBasket(medicineLibrary: MedicineLibrary, newValue: Int) {
        for basket in baskets {
            if basket.medicinelibrary == medicineLibrary {
                basket.qty = Int32(newValue)
            }
        }
    }
    
    func removeBasket(medicineLibrary: MedicineLibrary) {
        for (i,basket) in baskets.enumerated() {
            if basket.medicinelibrary?.medicine_name == medicineLibrary.medicine_name {
                baskets.remove(at: i)
                MedicineBasketRepository.shared.deleteMedicineBasket(basket: basket)
            }
        }
    }
    
    func addBasket(medicineLibrary: MedicineLibrary, qty: Int) {
        baskets.append(MedicineBasketRepository.shared.addMedicineBasket(qty: qty, medicineLibrary: medicineLibrary))
    }
}
