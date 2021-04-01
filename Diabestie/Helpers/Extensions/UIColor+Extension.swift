//
//  UIColor+Extension.swift
//  Diabestie
//
//  Created by Diabestie Team.
//  swiftlint:disable all

import UIKit

// MARK: - Colors Asset

extension UIColor {

    static let black = UIColor.color(named: "black")
    static let blueBlue = UIColor.color(named: "blue_blue")
    static let blueGreen = UIColor.color(named: "blue_green")
    static let bluePurple = UIColor.color(named: "blue_purple")
    static let charcoalGrey = UIColor.color(named: "charcoal_grey")
    static let grayBackground = UIColor.color(named: "gray_background")
    static let greenBackground = UIColor.color(named: "green_background")
    static let greenLight = UIColor.color(named: "green_light")
    static let lightPeriwinkle = UIColor.color(named: "light_periwinkle")
    static let paleGrey = UIColor.color(named: "pale_grey")
    static let purpleMedicine = UIColor.color(named: "purple_medicine")
    static let redBackground = UIColor.color(named: "red_background")
    static let redOrange = UIColor.color(named: "red_orange")
    static let reddishPink = UIColor.color(named: "reddish_pink")
    static let tangerine = UIColor.color(named: "tangerine")
    static let tangerineBackground = UIColor.color(named: "tangerine_background")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

