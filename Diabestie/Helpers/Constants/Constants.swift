//
//  Constants.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 31/03/21.
//

import Foundation
import UIKit

class Constants  {
    
    static let APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let footerHeight = 100
    static let dataModel = "Diabestie"
    static let globalUserEmail = "diabestie@nutrition.org"
    static let globalUserFirstName = "Diabestie"
    static let globalUserLastName = "Nutrition"
    static let globalUserPasword = "diabestie@nutrition.org"
   
    static let bloodSgrCategoryList = ["Add Category", "Fasting", "After Breakfast", "After Lunch", "After Dinner"]
    static let mealCategoryList = ["Add Category", "Breakfast", "Lunch", "Dinner", "Extra", "Snack"]
    static let medCategoryList = ["Add Category", "Before Breakfast", "After Breakfast", "Before Lunch", "After Lunch", "Before Dinner", "After Dinner"]

    enum DiaryEntries {
        case bloodSugar
        case food
        case medicine
    }
    
    static func BloodSugarLevelIndicator(indicator: BloodSugarLevelIndicatorCode) -> String {
        switch indicator {
        case .low:
            return "Low blood sugar level"
        case .stable:
            return "Stable blood sugar level"
        case .high:
            return "High blood sugar level"
        case .none:
            return "none"
        }
    }
    
    static func BloodSugarLevelIndicatorBGColor(indicator: BloodSugarLevelIndicatorCode) -> UIColor {
        switch indicator {
        case .low:
            return UIColor.tangerineBackground
        case .stable:
            return UIColor.greenBackground
        case .high:
            return UIColor.redBackground
        case .none:
            return UIColor.gray
        }
    }
    
    static func BloodSugarLevelIndicatorTxtColor(indicator: BloodSugarLevelIndicatorCode) -> UIColor {
        switch indicator {
        case .low:
            return UIColor.tangerine
        case .stable:
            return UIColor.greenLight
        case .high:
            return UIColor.reddishPink
        case .none:
            return UIColor.gray
        }
    }
    
    enum BloodSugarLevelIndicatorCode: Int {
        case low
        case stable
        case high
        case none
    }
    
}
