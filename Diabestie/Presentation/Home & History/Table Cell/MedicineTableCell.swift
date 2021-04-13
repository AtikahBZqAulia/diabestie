//
//  MedicineTableCell.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 01/04/21.
//

import UIKit

class MedicineTableCell: UITableViewCell {
    
    static let identifier = "MedicineTableCell"
    static let emptyStateidentifier = "EmptyMedicineHistoryTableCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var icChevron: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    
    var isHistory: Bool = false
    
    let contentCellId = MedicineTableCellItem.identifier
    var medicineBaskets = [MedicineBasket]()
    var medicineList = [MedicineEntries]()
    
    var medicineLibrary : [MedicineLibrary]? {
        return MedicineLibraryRepository.shared.getAllMedicineLibrary()
    }
    
    var medicineEntries : [MedicineEntries]? {
        didSet {
            onDataSet()
        }
    }
    
    var medicineEntry : MedicineEntries? {
        didSet {
            onDataSet()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func onDataSet(){
        
        if isHistory {
            if let data = medicineEntry {
                lblTime.text = data.created_at?.string(format: .HourMinutes)
                icChevron.isHidden = true
                lblCategory.text = Constants.medCategoryList[Int(medicineEntry!.category)]
                setupChildViews(dataEntry: data)
            }
        } else {
            let latestEntry = medicineEntries?.last
            if let data = latestEntry {
                lblTime.text = data.created_at?.string(format: .HourMinutes)
                setupChildViews(dataEntry: data)
            }
        }
    }
    
    
    func setupChildViews(dataEntry: MedicineEntries) {
        
        if isHistory {
            medicineBaskets = dataEntry.medicinebasket?.allObjects as! [MedicineBasket]
        }

        setupCollectionView()
        
    }
    
}


extension MedicineTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        collectionView?.showsHorizontalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView?.register(UINib(nibName: MedicineTableCellItem.identifier, bundle: nil), forCellWithReuseIdentifier: MedicineTableCellItem.identifier)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isHistory {
            return medicineBaskets.count
        } else {
            return medicineLibrary?.count ?? 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath) as? MedicineTableCellItem else {
            return UICollectionViewCell()
        }
        
        if isHistory {
            if indexPath.row == medicineBaskets.count - 1 {
                cell.viewDivider.isHidden = true
            }
            cell.medicineBasket = medicineBaskets[indexPath.row]
            
        } else {
            if indexPath.row == (medicineLibrary?.count ?? 1) - 1 {
                cell.viewDivider.isHidden = true
            }
            cell.medicineEntries = medicineEntries
            cell.medicineItem = medicineLibrary?[indexPath.row]
            
        }
                
        cell.backgroundColor = .red
        
        return cell
    }
        
}
