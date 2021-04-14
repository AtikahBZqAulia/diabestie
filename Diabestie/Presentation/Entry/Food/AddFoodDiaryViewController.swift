//
//  AddFoodDiaryViewController.swift
//  Diabestie
//
//  Created by Wilson Adrilia on 05/04/21.
//
import UIKit
import CoreData


protocol FoodEntryDelegate: class {
    func onCategoryPick(categoryId: Int)
    func onDateSelected(selectedDate: Date)
    func updateBasket(foodLibrary: FoodLibraries, newValue: Int)
}

class AddFoodDiaryViewController: UIViewController {

    @IBOutlet weak var foodEntryTableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var lblSugar: UILabel!
    @IBOutlet weak var lblCalories: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var caloriesTotalLabel: UILabel!
    @IBOutlet weak var caloriesKcalLabel: UILabel!
    
    @IBOutlet weak var middleLine: UIView!
    
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var sugarTotalLabel: UILabel!
    @IBOutlet weak var sugarMgLabel: UILabel!
    
    var foodList: [FoodLibraries] = []
    var foodBaskets: [FoodBasket] = []
    
    var selectedCategory: Int = 0 {
        didSet{
            validateData()
        }
    }
    
    var timeLog = Date()
    
    var foodEntry : FoodEntries? {
        didSet {
            onDataSet()
        }
    }
    
    func validateData() {
        
        print("SSS")
        
        if selectedCategory != 0 && !foodBaskets.isEmpty {
            saveButton.isEnabled = true
            saveButton.tintColor = .blueBlue
            return
        }
        saveButton.isEnabled = false
        saveButton.tintColor = .charcoalGrey
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        let baskets = NSMutableSet.init()
        for basket in foodBaskets {
            baskets.add(basket)
        }
        
        print("BASKTES FOOD \(baskets)")
        FoodEntryRepository.shared.insertFoodEntry(eatTime: selectedCategory , timeLog: self.timeLog, foodBasket: baskets)
        FoodLibraryRepository.shared.reseFoodLibrary()
        
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    @IBAction func undwindFoodSegue(_ sender: UIStoryboardSegue){
        validateData()
        self.foodEntryTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodList = FoodLibraryRepository.shared.getAllFoodLibrary()
        foodEntryTableView.dataSource = self
        foodEntryTableView.register(UINib(nibName: "FoodEmptyTableCell", bundle: nil), forCellReuseIdentifier: "FoodEmptyDataCell")
        
        
        // Do any additional setup after loading the view.
        saveButton.isEnabled = false
        saveButton.tintColor = .charcoalGrey
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SearchFoodViewController {
            let vc = segue.destination as! SearchFoodViewController
            vc.baskets = foodBaskets
            vc.timeLog = timeLog
        }
    }
    
    @IBAction func backPage(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension AddFoodDiaryViewController: FoodEntryDelegate {
    
    func updateBasket(foodLibrary: FoodLibraries, newValue: Int){
        for basket in foodBaskets {
            if basket.foodlibrary == foodLibrary {
                basket.qty = Int32(newValue)
            }
        }
    }
    
    func onCategoryPick(categoryId: Int) {
        print("sadasdsaa")
        self.selectedCategory = categoryId
    }
    
    func onDateSelected(selectedDate: Date) {
        print("sadasdsaa2323")
        self.timeLog = selectedDate
    }
    
    
}

extension AddFoodDiaryViewController: UITableViewDataSource{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }
    
        if section == 1 {
            if foodBaskets.isEmpty {
                return 1
            }
            return foodBaskets.count
        }
    
        return 2
    }
    
    func onDataSet(){
        if let data = foodEntry {
            
            let nutriton = FoodEntryRepository.shared.getFoodEntryTotalNutrition(entry: data)
            print("\(nutriton.sugar)")
            print("\(nutriton.calorie)")
            lblSugar.text = "\(nutriton.sugar)"
            lblCalories.text = "\(nutriton.calorie)"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                if let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: FoodInformationTableCell.identifier, for: indexPath) as? FoodInformationTableCell {
            
                    cell.delegate = self
                    return cell
                }
            }
            else if indexPath.row == 1 {
                let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: "foodButton", for: indexPath)
                return cell
            }
        }
        
        if indexPath.section == 1 {
            
            if foodBaskets.isEmpty {
                let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: "FoodEmptyDataCell") as! FoodEmptyTableCell
                return cell
            }
            
            if let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: ChosenFood.identifier, for: indexPath) as? ChosenFood{
                
                cell.delegate = self
                
                let foodData = self.foodBaskets[indexPath.row]
                            
                cell.foodLibrary = foodData.foodlibrary
                cell.foodName.text = foodData.foodlibrary?.food_name ?? ""
                cell.foodGram.text = "\(foodData.foodlibrary?.weight ?? 0) g"
                cell.foodCal.text = "\(foodData.foodlibrary?.calories ?? 0) kcal"
                cell.foodSugar.text = "\(foodData.foodlibrary?.sugar ?? 0) mg sugar"
                cell.stepperValue.text = "\(foodData.qty)"

//                if indexPath.row > 2
//                {addSeparator(cell)}
                return cell
            }
            
            else {
                return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: foodEntryTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
}
