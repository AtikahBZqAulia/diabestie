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
        
//        print("MDEINCE BEFORe \(medicineList)")
        
        for (index, data ) in medicineList.enumerated() {
            if let basket = self.baskets.first(where: {
                data == $0.medicinelibrary
            }) {
                
                print("THEDDD \(basket)")
                medicineList[index].ofMedicineBasket = basket
//                data.addToOfMedicineBasket(basket)
            }
        }
//        medicineList.forEach { (index,data) in
//
//
//        }

////            if data == basket.foodlibrary {
////                data.addToOfFoodBasket(basket)
////            }
//        }
//        print("MDEINCE After \(medicineList)")
//
//        medicineList.forEach { (data) in
//            if let basket = self.baskets.first(where: {
//                data.objectID == $0.medicinelibrary?.objectID
//            }) {
//
//                print("THEDDD \(data.ofMedicineBasket)")
////                medicineList[index].addToOfMedicineBasket(basket)
////                data.addToOfMedicineBasket(basket)
//            }
//        }

        
        addMedicineTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "CreateMedicine" {
            let destVC = segue.destination as! MedicineDiaryViewController
            destVC.medicineBasket = baskets
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.medicineList = MedicineLibraryRepository.shared.getAllMedicineLibrary()
        addMedicineTableView.reloadData()
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
                cell.medicineLibrary = medicineList[select]
                
                if let basket = medicineList[select].ofMedicineBasket{
            
                    cell.addButtonView.isHidden = true
                    cell.stepperView.isHidden = false
                    cell.stepperValue.text = "\(basket.qty)"

                } else {
                    cell.addButtonView.isHidden = false
                    cell.stepperView.isHidden = true
                    cell.stepperValue.text = "1"
                }
                
//                    if !self.baskets.isEmpty {
//                        if let data = self.baskets.first(where: {
//                            cell.medicineName.text == $0.medicinelibrary?.medicine_name
//                        }) {
//                            cell.addButtonView.isHidden = true
//                            cell.stepperView.isHidden = false
//                            cell.stepperValue.text = "\(data.qty)"
//                        }
//
//                    }
                
                cell.prepareForReuse()

//                if select != 0 && select != medicineList.count {
//                    addSeparator(cell)
//                }
                return cell
            }
            else {
                return UITableViewCell()
            }
        }
        
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: 31, y: 0, width: 390, height: 0.5))
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
            if basket.medicinelibrary == medicineLibrary {
                baskets.remove(at: i)
                MedicineBasketRepository.shared.deleteMedicineBasket(basket: basket)
            }
        }
    }
    
    func addBasket(medicineLibrary: MedicineLibrary, qty: Int) {
        baskets.append(MedicineBasketRepository.shared.addMedicineBasket(qty: qty, medicineLibrary: medicineLibrary))
    }
}
