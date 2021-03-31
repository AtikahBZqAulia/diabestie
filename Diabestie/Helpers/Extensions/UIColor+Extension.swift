//
//  UIColor+Extension.swift
//  Diabestie
//
//  Created by Diabestie Team.
//  swiftlint:disable all

import UIKit

// MARK: - Colors Asset

extension UIColor {

    static let accent = UIColor.color(named: "Accent")
    static let primary = UIColor.color(named: "Primary")
    static let secondary = UIColor.color(named: "Secondary")
    static let black = UIColor.color(named: "black")
    static let blue = UIColor.color(named: "blue")
    static let grayText = UIColor.color(named: "gray_text")
    static let greenBackground = UIColor.color(named: "green_background")
    static let greenFood = UIColor.color(named: "green_food")
    static let greenText = UIColor.color(named: "green_text")
    static let orangeBackground = UIColor.color(named: "orange_background")
    static let orangeText = UIColor.color(named: "orange_text")
    static let purpleMedicine = UIColor.color(named: "purple_medicine")
    static let purpleText = UIColor.color(named: "purple_text")
    static let redBackground = UIColor.color(named: "red_background")
    static let redBlood = UIColor.color(named: "red_blood")
    static let redText = UIColor.color(named: "red_text")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

