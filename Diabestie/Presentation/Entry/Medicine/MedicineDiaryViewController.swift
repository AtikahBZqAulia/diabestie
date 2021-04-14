//
//  MedicineDiaryViewController.swift
//  Diabestie
//
//  Created by Revarino Putra on 04/04/21.
//

import UIKit

protocol MedicineEntryDelegate: class {
    func onCategoryPick(categoryId: Int)
    func onDateSelected(selectedDate: Date)
    func updateBasket(medicineLibrary: MedicineLibrary, newValue: Int)
}

class MedicineDiaryViewController: UIViewController {

    @IBOutlet weak var medicineTableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var medicineBasket: [MedicineBasket]!
    var selectedCategory: Int = 0 {
        didSet {
            validateData()
        }
    }
    var timeLog = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicineTableView.dataSource = self
        medicineTableView.register(UINib(nibName: "EmptyTableCell", bundle: nil), forCellReuseIdentifier: "EmptyDataCell")
        self.medicineTableView.reloadData()
        saveButton.isEnabled = false
        saveButton.tintColor = .charcoalGrey
        
    }
    
    @IBAction func undwindSegue(_ sender: UIStoryboardSegue){
        self.medicineTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @IBAction func backToPreviousPage(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        let baskets = NSMutableSet.init()
        for basket in medicineBasket {
            baskets.add(basket)
        }
        MedicineEntryRepository.shared.insertMedicineEntry(category: self.selectedCategory, medicineBasket: baskets, time: self.timeLog)
        MedicineLibraryRepository.shared.resetMedicineLibrary()

        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if medicineBasket != nil {
            let vc = segue.destination as! AddMedicineDiaryViewController
            vc.baskets = medicineBasket
        }
    }
    
    func validateData() {
        if selectedCategory != 0 && medicineBasket != nil {
            saveButton.isEnabled = true
            saveButton.tintColor = .blueBlue
            return
        }
        saveButton.isEnabled = false
        saveButton.tintColor = .charcoalGrey
    }
   
}

extension MedicineDiaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if medicineBasket != nil {
            if medicineBasket.count == 0 {
                return 3
            }
            validateData()
            return medicineBasket.count + 2
        }
        else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = medicineTableView.dequeueReusableCell(withIdentifier: InformationTableCell.identifier, for: indexPath) as! InformationTableCell
            cell.delegate = self
            return cell
        }
        else if indexPath.row == 1 {
            let cell = medicineTableView.dequeueReusableCell(withIdentifier: "medicineButton", for: indexPath)
            return cell
        }
        
        else if indexPath.row > 1 && medicineBasket != nil{
            if medicineBasket.count != 0 {
                if let cell = medicineTableView.dequeueReusableCell(withIdentifier: ChosenMedicine.identifier, for: indexPath) as? ChosenMedicine{
                    cell.delegate = self
                    cell.medicineLibrary = medicineBasket[indexPath.row - 2].medicinelibrary
                    cell.medicineName.text = "\((medicineBasket[indexPath.row - 2].medicinelibrary?.medicine_name) ?? "")"
                    cell.medicineTimes.text = "\((medicineBasket[indexPath.row - 2].medicinelibrary?.consumption) ?? 1) times a day"
                    cell.stepperValue.text = "\(medicineBasket[indexPath.row - 2].qty)"
                    if indexPath.row > 2 {addSeparator(cell)}
                    return cell
                }
                return UITableViewCell()
            }
            
            else {
                let cell = medicineTableView.dequeueReusableCell(withIdentifier: "EmptyDataCell") as! EmptyTableCell
                return cell
            }
           
        }
        else {
            let cell = medicineTableView.dequeueReusableCell(withIdentifier: "EmptyDataCell") as! EmptyTableCell
            return cell
        }
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: medicineTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
}

extension MedicineDiaryViewController: MedicineEntryDelegate {
    func updateBasket(medicineLibrary: MedicineLibrary, newValue: Int) {
        for basket in medicineBasket {
            if basket.medicinelibrary == medicineLibrary {
                basket.qty = Int32(newValue)
            }
        }
    }
    
    func onCategoryPick(categoryId: Int) {
        self.selectedCategory = categoryId
    }
    
    func onDateSelected(selectedDate: Date) {
        self.timeLog = selectedDate
    }
    
    
}
