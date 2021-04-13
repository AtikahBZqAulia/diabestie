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
            filterText(searchController.searchBar.text!)
        } else {
            filteredData = self.foodList
            filtered = false
            self.foodTableView.reloadSections(IndexSet.init(integer: 1), with: .automatic)
        }
    }
    
    
    @IBOutlet weak var foodTableView: UITableView!
    
    var resultSearchController = UISearchController()
    
    var filteredData = [FoodLibraries]()
    var filtered = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filteredData.append(contentsOf: foodList)
        
        foodTableView.dataSource = self
        
        foodList = FoodLibraryRepository.shared.getAllFoodLibrary()
        
        print("BFOER FOOD LIST \(foodList)")
        
        let a1 = [["id":"1","color":"orange"],["id":"2","color":"red"]]
        let a2 = [["id":"1","fruit":"pumpkin"],["id":"2","fruit":"strawberry"]]

        let merged = Dictionary((a1+a2).map{($0["id"]!,Array($0))}){$0 + $1}
                     .map{Dictionary($1 as [(String,String)]){$1}}

        print(merged)
        
//        let mergs = Dictionary( (foodList+baskets).map{($) }  )
        
//        let basket = FoodBasketRepository.shared.addFoodBasket(qty: 2, foodLibrary: foodList[0])
        
        print("BEFORE FOOD LIST \(foodList)")

        foodList.forEach { (data) in
            
            if let basket = self.baskets.first(where: {
                data.objectID == $0.foodlibrary?.objectID
            }) {
                data.addToOfFoodBasket(basket)
            }
            
//            if data == basket.foodlibrary {
//                data.addToOfFoodBasket(basket)
//            }
        }

        print("CURRENT FOOD LIST \(foodList)")

        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            foodTableView.tableHeaderView = controller.searchBar
            foodTableView.dataSource = self
            return controller
        })()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AddFoodDiaryViewController
        destVC.foodBaskets = baskets
    }
    
}

extension SearchFoodViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
//        if section == 1 {
//            if !filteredData.isEmpty {
//                return filteredData.count
//            }
//            return filtered ? 0 : foodList.count
//        }
        
        return foodList.count
        
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
//                let select: Int = indexPath.row - 1
                cell.delegate = self
                
//                var stringTimes: String!
                
//                if !filteredData.isEmpty{
//                    let data = filteredData[indexPath.row]
//                    cell.foodName.text = "\(data.food_name ?? "")"
//                    cell.foodGram.text = "\(data.weight) g"
//                    cell.foodCal.text = "\(data.calories) kcal"
//                    cell.foodSugar.text = "\(data.sugar) mg sugar"
//                } else {
                    let data = self.foodList[indexPath.row]
                    cell.foodName.text = "\(data.food_name ?? "")"
                    cell.foodGram.text = "\(data.weight) g"
                    cell.foodCal.text = "\(data.calories) kcal"
                    cell.foodSugar.text = "\(data.sugar) mg sugar"
//                }
                
                //                cell.foodName.text = stringTimes
                
                
//                print("OF FOOD BASKET \(data.ofFoodBasket)")
                
//                let basketData = data.ofFoodBasket as! FoodBasket
//                if !self.baskets.isEmpty {
//                    if let data = self.baskets.first(where: {
//                        cell.foodName.text == $0.foodlibrary?.food_name
//                    }) {
                        cell.addButtonView.isHidden = true
                        cell.stepperView.isHidden = false
//                cell.stepperValue.text = "\(basketData.qty)"
//                    }
//
//                }
                
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
