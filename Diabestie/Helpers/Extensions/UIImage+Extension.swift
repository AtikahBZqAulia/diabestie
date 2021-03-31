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

    static let blood = UIImage.image(named: "blood")

    private static func image(named: String) -> UIImage {
        return UIImage(named: named)!
    }
}
