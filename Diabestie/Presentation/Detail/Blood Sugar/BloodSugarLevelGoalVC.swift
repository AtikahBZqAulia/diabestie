//
//  BloodSugarLevelGoalVC.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 05/04/21.
//

import UIKit

class BloodSugarLevelGoalVC: UITableViewController {
    
    @IBOutlet weak var edtFastingUpperBound: UITextField!
    @IBOutlet weak var edtFastingLowerBound: UITextField!
    @IBOutlet weak var edtMealUpperBound: UITextField!
    @IBOutlet weak var edtMealLowerBound: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.isEnabled = false
        
        initializeView()
        
    }
    
    func initializeView() {
        if let constraintData = getBloodSugarConstraint {
            self.edtMealLowerBound.text = "\(constraintData.am_lower_bound)"
            self.edtMealUpperBound.text = "\(constraintData.am_upper_bound)"
            self.edtFastingLowerBound.text = "\(constraintData.f_lower_bound)"
            self.edtFastingUpperBound.text = "\(constraintData.f_upper_bound)"
            
        }
    }
    
    @IBAction func onSaveButtonTap(_ sender: Any) {
        let mealLowerBound = Int(self.edtMealLowerBound.text ?? "0") ?? 0
        let mealUpperBound =  Int(self.edtMealUpperBound.text ?? "0") ?? 0
        let fastingLowerBound = Int(self.edtFastingLowerBound.text ?? "0") ?? 0
        let fastingUpperBound = Int(self.edtFastingUpperBound.text ?? "0") ?? 0
        
        UserRepository.shared.insertBloogSugarConstraint(am_upper: mealUpperBound, am_lower: mealLowerBound, f_upper: fastingUpperBound, f_lower: fastingLowerBound)
        
        self.performSegue(withIdentifier: "unwindToBloodSugarDetail", sender: self)
    }
    
}

extension BloodSugarLevelGoalVC {
    
    var getBloodSugarConstraint: BloodSugarConstraints? {
        return UserRepository.shared.getCurrentUser()?.bloodsugarconstraint
    }
    
}

extension BloodSugarLevelGoalVC {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame
        
        let title = UILabel()
        title.frame =  CGRect(x: 16, y: 20, width: headerFrame.size.width-20, height: 20) //width equals to parent view with 10 left and right margin
        title.font = title.font.withSize(14)
        title.text = self.tableView(tableView, titleForHeaderInSection: section) //This will take title of section from 'titleForHeaderInSection' method or you can write directly
        title.textColor = .charcoalGrey
        
        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.addSubview(title)
        
        return headerView
    }
    
}

extension BloodSugarLevelGoalVC: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        bloodSugarTextField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        validateData()
    }
    
    func validateData(){
        
        let mealLowerBound = self.edtMealLowerBound.text?.isEmpty ?? false
        let mealUpperBound = self.edtMealUpperBound.text?.isEmpty ?? false
        let fastingLowerBound = self.edtFastingLowerBound.text?.isEmpty ?? false
        let fastingUpperBound = self.edtFastingUpperBound.text?.isEmpty ?? false
        
        if mealLowerBound ||  mealUpperBound || fastingLowerBound || fastingUpperBound {
            self.saveBtn.isEnabled = false
            return
        }
        
        self.saveBtn.isEnabled = true
    }
    
}
