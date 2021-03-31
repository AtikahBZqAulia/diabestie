//
//
//  UIImage+Extension.swift
//  Diabestie
//
//  Created by Diabestie Team.
//  swiftlint:disable all

import UIKit

// MARK: - Images Asset

extension UIImage {

    static let icBlood = UIImage.image(named: "ic_blood")
    static let icCheck = UIImage.image(named: "ic_check")
    static let icDate = UIImage.image(named: "ic_date")
    static let icDown = UIImage.image(named: "ic_down")
    static let icFood = UIImage.image(named: "ic_food")
    static let icMedicine = UIImage.image(named: "ic_medicine")
    static let icUp = UIImage.image(named: "ic_up")
    static let placeholderPerson = UIImage.image(named: "placeholder_person")

    private static func image(named: String) -> UIImage {
        return UIImage(named: named)!
    }
}
