//
//  ViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 24/03/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPullToRefresh()
        setupTableView()
    }
    
    func setupPullToRefresh(){
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func deleteAllLocalData(_ sender: Any) {
        
        CommonFunction.shared.showAlertWithCompletion(self, title: "Alert", message: "Delete all data?") {
            CoreDataManager.sharedManager.deleteAllData()
            self.tableView.reloadData()
        } failureBlock: {
            // no action yet
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
}

extension HomeViewController {
    
    var latestBloodSugarEntries: BloodSugarEntries? {
         return BloodSugarEntryRepository.shared.getBloodSugarEntryByDate(date: Date()).last
    }
    
    var latestFoodEntries: FoodEntries? {
         return FoodEntryRepository.shared.getFoodEntryByDate(date: Date()).last
    }
    
    func medicineLibrary() -> [MedicineLibrary] {
        return MedicineLibraryRepository.shared.getAllMedicineLibrary()
    }
    
    func todayBloodSugarEntries() -> [BloodSugarEntries] {
        return BloodSugarEntryRepository.shared.getBloodSugarEntryByDate(date: Date())
    }
    func todayFoodEntries() -> [FoodEntries] {
        return FoodEntryRepository.shared.getFoodEntryByDate(date: Date())
    }
    func todayMedicineEntries() -> [MedicineEntries] {
        return MedicineEntryRepository.shared.getMedicineEntryByDate(date: Date())
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView(){
        tableView.register(UINib(nibName: BloodSugarTableCell.identifier, bundle: nil), forCellReuseIdentifier: BloodSugarTableCell.identifier)
        tableView.register(UINib(nibName: FoodTableCell.identifier, bundle: nil), forCellReuseIdentifier: FoodTableCell.identifier)
        tableView.register(UINib(nibName: MedicineTableCell.identifier, bundle: nil), forCellReuseIdentifier: MedicineTableCell.identifier)

    }
    
    func tableviewIdentifier() -> [String] {
        var identifiers = [String]()
        
        todayBloodSugarEntries().isEmpty ?
            identifiers.append(BloodSugarTableCell.emptyStateidentifier) : identifiers.append(BloodSugarTableCell.identifier)
        
        todayFoodEntries().isEmpty ?
            identifiers.append(FoodTableCell.emptyStateidentifier) : identifiers.append(FoodTableCell.identifier)
        
        medicineLibrary().isEmpty ?
            identifiers.append(MedicineTableCell.emptyStateidentifier) : identifiers.append(MedicineTableCell.identifier)
        
      
        identifiers.append(AddDiaryTableCell.identifier)
        
        return identifiers
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(Constants.footerHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewIdentifier().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = self.tableviewIdentifier()[indexPath.row]
        
        switch identifier {
        case AddDiaryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddDiaryTableCell else {
                return UITableViewCell()
            }
            return cell
        case BloodSugarTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BloodSugarTableCell else {
                return UITableViewCell()
            }
            
            cell.bloodSugarEntry = latestBloodSugarEntries
        
            return cell
        case FoodTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FoodTableCell else {
                return UITableViewCell()
            }
            
            cell.foodEntries = todayFoodEntries()
            cell.onDataSet()

            return cell
        case MedicineTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MedicineTableCell else {
                return UITableViewCell()
            }
            
            cell.medicineEntries = todayMedicineEntries()
            return cell
        case DiaryHistoryTableCell.identifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DiaryHistoryTableCell else {
                return UITableViewCell()
            }
            return cell
        case BloodSugarTableCell.emptyStateidentifier:

            guard let cell = tableView.dequeueReusableCell(withIdentifier: BloodSugarTableCell.cellIdentifier()) as? BloodSugarTableCell else {
                return UITableViewCell()
            }
            cell.onDataSetEmptyState()
            
//            cell.lblTitle.text = "Blood Sugar Level"
//            cell.lblDescription.text = "Woi, sini absen gula dulu"
//            cell.lblTitle.textColor = .redOrange
//            cell.icEmptyState.image = UIImage(systemName: "drop.fill")
//            cell.icEmptyState.tintColor = .redOrange
        
            return cell
        case FoodTableCell.emptyStateidentifier:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableCell.cellIdentifier()) as? FoodTableCell else {
                return UITableViewCell()
            }
            cell.onDataSetEmptyState()
            
//            cell.lblTitle.text = "Food Intake"
//            cell.lblDescription.text = "Mulai lapar"
//            cell.lblTitle.textColor = .blueGreen
//            cell.icEmptyState.image = #imageLiteral(resourceName: "food")
//            cell.icEmptyState.tintColor = .blueGreen

            return cell
        case MedicineTableCell.emptyStateidentifier:
            print("kosong")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyStateCell.cellIdentifier()) as? HomeEmptyStateCell else {
                return UITableViewCell()
            }
            
            cell.lblTitle.text = "Medicine Intake"
            cell.lblDescription.text = "You haven't add any medicines yet.\nPlease go to Medicine Detail > Medicine List > Create Medicine"
            cell.lblDetail.text = "Medicine Detail"
            cell.lblTitle.textColor = .purpleMedicine
            cell.icEmptyState.image = UIImage(systemName: "pills.fill")
            cell.icEmptyState.tintColor = .purpleMedicine

            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let identifier = self.tableviewIdentifier()[indexPath.row]
        
        switch identifier {
        case MedicineTableCell.identifier:
            return 115
        case BloodSugarTableCell.emptyStateidentifier:
            return 115
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = self.tableviewIdentifier()[indexPath.row]
        
        switch identifier {
        case MedicineTableCell.identifier:
            self.performSegue(withIdentifier: "MedicineDetailSegue", sender: nil)
        case FoodTableCell.identifier:
            self.performSegue(withIdentifier: "FoodDetailSegue", sender: nil)
        case BloodSugarTableCell.identifier:
            self.performSegue(withIdentifier: "BloodSugarDetailSegue", sender: nil)
        case MedicineTableCell.emptyStateidentifier:
            self.performSegue(withIdentifier: "MedicineDetailSegue", sender: nil)
        case FoodTableCell.emptyStateidentifier:
            self.performSegue(withIdentifier: "FoodDetailSegue", sender: nil)
        case BloodSugarTableCell.emptyStateidentifier:
            self.performSegue(withIdentifier: "BloodSugarDetailSegue", sender: nil)
        default:
            print("No segue found")
        }
    }
    
}
