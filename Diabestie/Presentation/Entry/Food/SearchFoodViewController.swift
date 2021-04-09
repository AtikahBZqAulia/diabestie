//
//  ViewController.swift
//  SearchableTableView
//
//  Created by Atikah Aulia on 07/04/21.
//

import UIKit
class SearchFoodViewController: UIViewController{
    
    @IBOutlet weak var foodTableView: UITableView!
    
    private let foodNames = ["Pisang", "Nasi", "Marugame", "Kol"]
    private let Grams = ["100", "100", "60", "90"]
    private let Cal = ["39", "130", "340", "40"]
    private let Sugar = ["15", "30", "18", "35"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTableView.dataSource = self
    }
    
    @IBAction func backToPrevious(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchFoodViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodNames.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = foodTableView.dequeueReusableCell(withIdentifier: "searchFoods", for: indexPath)
            return cell
        }
        else if indexPath.row == 1{
            let cell = foodTableView.dequeueReusableCell(withIdentifier: "Recents", for: indexPath)
            return cell
        }
        else {
            if let cell = foodTableView.dequeueReusableCell(withIdentifier: "foodList", for: indexPath) as? AddFoodTableCell
            {
                
                let select: Int = indexPath.row - 1
                
                cell.foodName.text = foodNames[select]
                cell.foodGram.text = "\(Grams[select]) g"
                cell.foodCal.text = "\(Cal[select]) kcal"
                cell.foodSugar.text = "\(Sugar[select]) mg sugar"
                if select != 0 && select != foodNames.count {
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
        let separatorView = UIView(frame: CGRect(x: foodTableView.separatorInset.left, y: 0, width: 390, height: 0.5))
        separatorView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.36)
        cell.contentView.addSubview(separatorView)
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

