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

    static let icSearch = UIImage.image(named: "ic_search")

    private static func image(named: String) -> UIImage {
        return UIImage(named: named)!
    }
}
