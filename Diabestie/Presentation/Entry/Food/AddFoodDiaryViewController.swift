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
    
    var names: [String] = []
    var foodGram: [Int] = []
    var foodCal: [Int] = []
    var foodSugar: [Int] = []
    
    var foodList: [FoodLibraries] = []
    var foodBaskets: [FoodBasket] = []
    var selectedCategory: Int=0{
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
        let c = segue.destination as! SearchFoodViewController
        c.baskets = foodBaskets
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodBaskets != nil{
            if foodBaskets.count == 0{
                return 3
            }
            
        }
        
        
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: "informationSection", for: indexPath)
            return cell
        }
        else if indexPath.row == 1 {
            let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: "foodButton", for: indexPath)
            return cell
        }
        else if indexPath.row > 1 && names.count != 0{
            if let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: ChosenFood.identifier, for: indexPath) as? ChosenFood{
                cell.foodName.text = names[indexPath.row - 2]
                cell.foodGram.text = "\(foodGram[indexPath.row - 2]) g"
                cell.foodCal.text = "\(foodGram[indexPath.row - 2]) kcal"
                cell.foodSugar.text = "\(foodSugar[indexPath.row - 2]) mg sugar"
                if indexPath.row > 2
                {addSeparator(cell)}
                return cell
            }
            
            else {
                return UITableViewCell()
            }
           
        }
        else {
            let cell = foodEntryTableView.dequeueReusableCell(withIdentifier: "FoodEmptyDataCell") as! FoodEmptyTableCell
            return cell
        }
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: foodEntryTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
}

extension AddFoodDiaryViewController: FoodBasketDelegate{
    func removeBasket(foodLibrary: FoodLibraries) {
        for (i, foodBaskets) in foodBaskets.enumerated(){
            if foodBaskets.foodlibrary?.food_name == foodLibrary.food_name{
//                foodBaskets.remove(at: i)
                FoodBasketRepository.shared.deleteFoodBasket(basket: foodBaskets)
            }
        }
    }
    
    func addBasket(foodLibrary: FoodLibraries, qty: Int) {
        foodBaskets.append(FoodBasketRepository.shared.addFoodBasket(qty: qty, foodLibrary: foodLibrary))
    }
    
    
    func updateBasket(foodLibrary: FoodLibraries, newValue:Int){
        for item in foodBaskets {
            if item.foodlibrary == foodLibrary{
                item.qty = Int32(newValue)
            }
        }
    }
}


