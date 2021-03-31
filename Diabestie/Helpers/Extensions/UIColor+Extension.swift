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

    private static func color(named: String) -> UIColor {
        return UIColor(named: named)!
    }

}

