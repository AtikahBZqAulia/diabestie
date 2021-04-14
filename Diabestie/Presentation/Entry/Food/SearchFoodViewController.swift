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

class SearchFoodViewController: UIViewController, UISearchResultsUpdating{
    
    var foodList: [FoodLibraries] = []
    var baskets: [FoodBasket] = []
    
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.searchBar.text!.isEmpty {
            self.headerTitle = "Result for \"\(searchController.searchBar.text!)\""
            filterText(searchController.searchBar.text!)
        } else {
            filteredData = self.foodList
            filtered = false
            self.headerTitle = "Recents"
            self.foodTableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        }
    }
    
    
    @IBOutlet weak var foodTableView: UITableView!
    
    var resultSearchController = UISearchController()
    
    var filteredData = [FoodLibraries]()
    var filtered = false
    
    var timeLog = Date()
    
    var headerTitle = "Recents"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        foodList = FoodLibraryRepository.shared.getAllFoodLibrary()
        
        for (index, data ) in foodList.enumerated() {
            if let basket = self.baskets.first(where: {
                data == $0.foodlibrary
            }) {
                foodList[index].ofFoodBasket = basket
            }
        }
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            foodTableView.tableHeaderView = controller.searchBar
            foodTableView.dataSource = self
            return controller
        })()
        
        foodList.sort { (data, value) -> Bool in
           return data.ofFoodBasket != nil
        }
        
        self.filteredData.append(contentsOf: foodList)
        
        foodTableView.dataSource = self
        foodTableView.delegate = self

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is AddFoodDiaryViewController {
            let destVC = segue.destination as! AddFoodDiaryViewController
            destVC.foodBaskets = baskets
        }
        
    }
    
}

extension SearchFoodViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if section == 1 {
            
            let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.textLabel?.font = .systemFont(ofSize: 24, weight: .bold)
            header.textLabel?.textColor = .black
            header.textLabel?.text =  header.textLabel?.text?.capitalized
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        if section == 1 {
            return headerTitle
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            if !filteredData.isEmpty {
                return filteredData.count
            }
            return filtered ? 0 : foodList.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            if let cell = foodTableView.dequeueReusableCell(withIdentifier: "foodList", for: indexPath) as? AddFoodTableCell
            {
                
                cell.delegate = self
                
                let data: FoodLibraries = filtered ? filteredData[indexPath.row] : foodList[indexPath.row]
                
                cell.foodLibrary = data
                cell.foodName.text = "\(data.food_name ?? "")"
                cell.foodGram.text = "\(data.weight) g"
                cell.foodCal.text = "\(data.calories) kcal"
                cell.foodSugar.text = "\(data.sugar) mg sugar"
                
                if let basket = data.ofFoodBasket {
                    
                    cell.addButtonView.isHidden = true
                    cell.stepperView.isHidden = false
                    cell.stepperValue.text = "\(basket.qty)"
                    
                    if basket.qty == 0 {
                        cell.addButtonView.isHidden = false
                        cell.stepperView.isHidden = true
                        cell.stepperValue.text = "1"
                    }
                    
                } else {
                    cell.addButtonView.isHidden = false
                    cell.stepperView.isHidden = true
                    cell.stepperValue.text = "1"
                }
                
//                if indexPath.row != 0 && indexPath.row != self.foodList.count {
//                    addSeparator(cell)
//                }
                
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
        
        for (index, data ) in filteredData.enumerated() {
            if let basket = self.baskets.first(where: {
                data == $0.foodlibrary
            }) {
                
                print("THEDDD \(basket)")
                filteredData[index].ofFoodBasket = basket
            }
        }
        
        filteredData.sort { (data, value) -> Bool in
           return data.ofFoodBasket != nil
        }
        
        if query.count < 2 {
            self.foodTableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        } else {
            self.foodTableView.reloadSections(IndexSet.init(integer: 1), with: .none)
        }
        
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
        baskets.append(FoodBasketRepository.shared.addFoodBasket(qty: qty, timeLog: timeLog, foodLibrary: foodLibrary))
    }
}
