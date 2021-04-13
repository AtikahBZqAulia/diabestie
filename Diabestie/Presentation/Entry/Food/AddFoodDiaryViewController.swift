//
//  AddFoodDiaryViewController.swift
//  Diabestie
//
//  Created by Wilson Adrilia on 05/04/21.
//
import UIKit
import CoreData


class AddFoodDiaryViewController: UIViewController {

    @IBOutlet weak var foodEntryTableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var foodList: [FoodLibraries] = []
    var foodBaskets: [FoodBasket] = []
    
    var selectedCategory: Int = 0 {
        didSet{
            validateData()
        }
    }
    var eatTime = 0
    var timeLog = Date()
    
    func validateData() {
        if selectedCategory != 0 && foodBaskets != nil {
            saveButton.isEnabled = true
            saveButton.tintColor = .blueBlue
            return
        }
        saveButton.isEnabled = false
        saveButton.tintColor = .charcoalGrey
    }
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        let baskets = NSMutableSet.init()
        for basket in baskets {
            baskets.add(basket)
        }
        FoodEntryRepository.shared.insertFoodEntry(eatTime: eatTime , timeLog: self.timeLog, foodBasket: baskets)

        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func undwindFoodSegue(_ sender: UIStoryboardSegue){
        self.foodEntryTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodList = FoodLibraryRepository.shared.getAllFoodLibrary()
        foodEntryTableView.dataSource = self
        foodEntryTableView.register(UINib(nibName: "FoodEmptyTableCell", bundle: nil), forCellReuseIdentifier: "FoodEmptyDataCell")
        
        
        // Do any additional setup after loading the view.
//        saveButton.isEnabled = false
//        saveButton.tintColor = .charcoalGrey
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SearchFoodViewController {
            let vc = segue.destination as! SearchFoodViewController
            vc.baskets = foodBaskets
        }
    }
    
    @IBAction func backPage(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSaveButtonTap(_ sender: Any){
        saveFoodBasketData()
    }
    
}

    

extension AddFoodDiaryViewController: UITableViewDataSource{
    
    func saveFoodBasketData(){
        
    }
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: "informationSection", for: indexPath)
                return cell
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
                
                let foodData = self.foodBaskets[indexPath.row]
                            
                cell.foodName.text = foodData.foodlibrary?.food_name ?? ""
                cell.foodGram.text = "\(foodData.foodlibrary?.weight ?? 0) g"
                cell.foodCal.text = "\(foodData.foodlibrary?.calories ?? 0) kcal"
                cell.foodSugar.text = "\(foodData.foodlibrary?.sugar ?? 0) mg sugar"
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

extension AddFoodDiaryViewController: FoodBasketDelegate{
    func removeBasket(foodLibrary: FoodLibraries) {
        for (_, foodBaskets) in foodBaskets.enumerated(){
            if foodBaskets.foodlibrary?.food_name == foodLibrary.food_name{
//                foodBaskets.remove(at: i)
                FoodBasketRepository.shared.deleteFoodBasket(basket: foodBaskets)
            }
        }
    }
    
    func addBasket(foodLibrary: FoodLibraries, qty: Int) {
        foodBaskets.append(FoodBasketRepository.shared.addFoodBasket(qty: qty, foodLibrary: foodLibrary))
    }
    
//    func removeBasket(foodLibrary: FoodLibraries) {
//        for (i, foodBaskets) in foodBaskets.enumerated(){
//            if foodBaskets.foodlibrary?.food_name == foodLibrary.food_name{
//                foodBaskets.remove(at: i)
//                FoodBasketRepository.shared.deleteFoodBasket(basket: foodBaskets)
//            }
//        }
//    }
    
    func updateBasket(foodLibrary: FoodLibraries, newValue:Int){
        for item in foodBaskets {
            if item.foodlibrary == foodLibrary{
                item.qty = Int32(newValue)
            }
        }
    }
}


