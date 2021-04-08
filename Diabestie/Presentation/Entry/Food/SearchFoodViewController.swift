//
//  ViewController.swift
//  SearchableTableView
//
//  Created by Atikah Aulia on 07/04/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!
    
    var data = [String]()
    var filteredData = [String]()
    var filtered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text{
            filterText(text+string)
        }
        
        return true
    }
    
    func filterText (_ query: String) {
        
        filteredData.removeAll()
        for string in data{
            if string.lowercased().starts(with: query.lowercased()){
                filteredData.append(string)
            }
        }
        table.reloadData()
        filtered = true
    }
    
    private func setupData(){
        data.append("Marugame")
        data.append("Nasi Uduk")
        data.append("Nasi Padang")
        data.append("Nasi Kebuli")
        data.append("Pisang")
        data.append("Pisang Bakar")
        data.append("Nutella")
        data.append("Hotdog")
        data.append("Salad")
        data.append("Tumis Kangkung")
        data.append("Tahu")
        data.append("Sayur Asem")
        data.append("Sayur Sop")
        data.append("Tempe")
        data.append("Ayam")
        data.append("Ayam KFC")
        data.append("Apel")
        data.append("Mangga")
        data.append("Jambu")
        data.append("Nasi Merah")
        data.append("Tom Yum")
        data.append("Sate Ayam")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData.isEmpty {
            return filteredData.count
        }
        return filtered ? 0 : data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if !filteredData.isEmpty{
            cell.textLabel?.text = filteredData[indexPath.row]
        }
        else{
            cell.textLabel?.text = data[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

