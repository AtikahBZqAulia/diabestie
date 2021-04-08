//
//  AddFoodDiaryViewController.swift
//  Diabestie
//
//  Created by Wilson Adrilia on 05/04/21.
//

import UIKit

class AddFoodDiaryViewController: UIViewController {

    @IBOutlet weak var foodEntryTableView: UITableView!
    
    var names: [String] = []
    var foodGram: [Int] = []
    var foodCal: [Int] = []
    var foodSugar: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodEntryTableView.dataSource = self
        foodEntryTableView.register(UINib(nibName: "FoodEmptyTableCell", bundle: nil), forCellReuseIdentifier: "FoodEmptyDataCell")
        self.navigationController?.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension AddFoodDiaryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = names.count
        if value != 0 {
            return value + 2
        }
        else {
            return 3
        }
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
