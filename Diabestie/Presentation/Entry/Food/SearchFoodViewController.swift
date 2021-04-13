//
//  ViewController.swift
//  SearchableTableView
//
//  Created by Atikah Aulia on 07/04/21.
//

import UIKit

protocol FoodBasketDelegate: class {
    func addBasket (foodLibrary: FoodLibraries, qty: Int)
    func removeBasket (foodLibrary: FoodLibraries)
    func updateBasket(foodLibrary: FoodLibraries, newValue: Int)
}

struct Foods {
    let foodname : String
    let grams : String
    let cal : String
    let sugar : String
}

class SearchFoodViewController: UIViewController, UISearchResultsUpdating{
  
    var foodList: [FoodLibraries] = []
    var baskets: [FoodBasket] = []
    
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.searchBar.text!.isEmpty {
            filterText(searchController.searchBar.text!)
        } else {
            filteredData = self.foodList
            filtered = false
            self.foodTableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        }
    }
    
    
    @IBOutlet weak var foodTableView: UITableView!
    
    var resultSearchController = UISearchController()

    
    var foods: [Foods] = []
    
    var filteredData = [FoodLibraries]()
    var filtered = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        foods.append(Foods(foodname: "Pisang", grams: "100", cal: "39", sugar: "15"))
//        foods.append(Foods(foodname: "Nasi", grams: "10", cal: "10", sugar: "5"))
//        foods.append(Foods(foodname: "Marugame", grams: "20", cal: "10", sugar: "2"))
//        foods.append(Foods(foodname: "Kol", grams: "30", cal: "10", sugar: "3"))
        
        self.filteredData.append(contentsOf: foodList)
        
        
        foodTableView.dataSource = self
        
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            foodTableView.tableHeaderView = controller.searchBar
            foodList = FoodLibraryRepository.shared.getAllFoodLibrary()
            foodTableView.dataSource = self
            return controller
        })()
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AddFoodDiaryViewController
        destVC.foodBaskets = baskets
    }
    
//    @IBAction func backToPrevious(_ sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
}

extension SearchFoodViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        if section == 1 {
            if !filteredData.isEmpty {
                return filteredData.count
            }
            return filtered ? 0 : foodList.count
        }
        
        return foodList.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
//            if indexPath.row == 0 {
//                let cell = foodTableView.dequeueReusableCell(withIdentifier: "searchFoods", for: indexPath)
//
//                let searchView = cell.viewWithTag(100) as! UISearchBar
//                searchView.delegate = self
//
//                return cell
//            }
            if indexPath.row == 0{
                let cell = foodTableView.dequeueReusableCell(withIdentifier: "Recents", for: indexPath)
                return cell
            }
            
        }
        
        
        if indexPath.section == 1 {
            
            if let cell = foodTableView.dequeueReusableCell(withIdentifier: "foodList", for: indexPath) as? AddFoodTableCell
            {
                let select: Int = indexPath.row - 1
                cell.delegate = self
                
                var stringTimes: String!
                
                if !filteredData.isEmpty{
                    let data = filteredData[indexPath.row]
                    cell.foodName.text = "\(data.food_name ?? "")"
                    cell.foodGram.text = "\(data.weight) g"
                    cell.foodCal.text = "\(data.calories) kcal"
                    cell.foodSugar.text = "\(data.sugar) mg sugar"
                } else {
                    let data = self.foodList[indexPath.row]
                    cell.foodName.text = "\(data.food_name ?? "")"
                    cell.foodGram.text = "\(data.weight) g"
                    cell.foodCal.text = "\(data.calories) kcal"
                    cell.foodSugar.text = "\(data.sugar) mg sugar"
                }
                
                if indexPath.row != 0 && indexPath.row != self.foodList.count {
                    addSeparator(cell)
                }
                
                return cell
            }
            else{
                return UITableViewCell()
            }
            
        }
        return UITableViewCell()
    }
    
    private func addSeparator(_ cell: UITableViewCell) -> Void {
        let separatorView = UIView(frame: CGRect(x: foodTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
    }
    
}

extension SearchFoodViewController: UISearchBarDelegate{
    
    func filterText (_ query: String) {
        
        filteredData = []
        for foodData in foodList{
            if foodData.food_name!.lowercased().starts(with: query.lowercased()){
                filteredData.append(foodData)
            }
        }
        
        print("Filtered data \(filteredData)")
        
        self.foodTableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        filtered = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    }
}

extension SearchFoodViewController: FoodBasketDelegate {
    func updateBasket(foodLibrary: FoodLibraries, newValue: Int){
        for basket in baskets {
            if basket.foodlibrary == foodLibrary {
                basket.qty = Int32(newValue)
            }
        }
    }
    
    func removeBasket(foodLibrary: FoodLibraries) {
        for (i,basket) in baskets.enumerated() {
            if basket.foodlibrary == foodLibrary {
                baskets.remove(at: i)
                FoodBasketRepository.shared.deleteFoodBasket(basket: basket)
            }
        }
    }
    
    func addBasket(foodLibrary: FoodLibraries, qty: Int){
        baskets.append(FoodBasketRepository.shared.addFoodBasket(qty: qty, foodLibrary: foodLibrary))
    }
}





//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
//
//
//    @IBOutlet var table: UITableView!
//    @IBOutlet var field: UITextField!
//
//    var data = [String]()
//    var filteredData = [String]()
//    var filtered = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupData()
//        table.delegate = self
//        table.dataSource = self
//        field.delegate = self
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let text = textField.text{
//            filterText(text+string)
//        }
//
//        return true
//    }
//
//    func filterText (_ query: String) {
//
//        filteredData.removeAll()
//        for string in data{
//            if string.lowercased().starts(with: query.lowercased()){
//                filteredData.append(string)
//            }
//        }
//        table.reloadData()
//        filtered = true
//    }
//
//    private func setupData(){
//        data.append("Marugame")
//        data.append("Nasi Uduk")
//        data.append("Nasi Padang")
//        data.append("Nasi Kebuli")
//        data.append("Pisang")
//        data.append("Pisang Bakar")
//        data.append("Nutella")
//        data.append("Hotdog")
//        data.append("Salad")
//        data.append("Tumis Kangkung")
//        data.append("Tahu")
//        data.append("Sayur Asem")
//        data.append("Sayur Sop")
//        data.append("Tempe")
//        data.append("Ayam")
//        data.append("Ayam KFC")
//        data.append("Apel")
//        data.append("Mangga")
//        data.append("Jambu")
//        data.append("Nasi Merah")
//        data.append("Tom Yum")
//        data.append("Sate Ayam")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if !filteredData.isEmpty {
//            return filteredData.count
//        }
//        return filtered ? 0 : data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        if !filteredData.isEmpty{
//            cell.textLabel?.text = filteredData[indexPath.row]
//        }
//        else{
//            cell.textLabel?.text = data[indexPath.row]
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//
//}

