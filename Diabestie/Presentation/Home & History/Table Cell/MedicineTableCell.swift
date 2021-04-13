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
    
    var isHistory: Bool = false
    
    let contentCellId = MedicineTableCellItem.identifier
    var medicineBaskets = [MedicineBasket]()
    
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
        
        if let data = medicineEntry {
            
            lblTime.text = data.created_at?.string(format: .HourMinutes)

            if isHistory {
                icChevron.isHidden = true
            }
            
            
            setupChildViews(dataEntry: data)
        }
    }
    
    
    func setupChildViews(dataEntry: MedicineEntries) {
        
        medicineBaskets = dataEntry.medicinebasket?.allObjects as! [MedicineBasket]
        
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
        return medicineBaskets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath) as? MedicineTableCellItem else {
            return UICollectionViewCell()
        }
        
        
        if indexPath.row == medicineBaskets.count - 1 {
            cell.viewDivider.isHidden = true
        }
                
        cell.backgroundColor = .red
        cell.medicineBasket = medicineBaskets[indexPath.row]
        
        return cell
    }
        
}
