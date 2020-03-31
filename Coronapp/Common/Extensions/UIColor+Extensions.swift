//
//  UIColor+Extensions.swift
//  Common
//
//  Created by Barış Uyar on 28.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit


public extension UIColor {
    
    static let backgroundColor = UIColor(hex: 0x000513)
    static let textColor = UIColor(hex: 0xEEEEEE)
    static let appLightTextColor = UIColor(hex: 0x818181)
    static let cardBackgroundColor = UIColor(hex: 0x222831)
    static let appOrange = UIColor(hex: 0xEF962D)
    static let appCyan = UIColor(hex: 0x47D4BB)
    static let appRed = UIColor(hex: 0xE14D4D)
    static let lightCardBackgroundColor = UIColor(hex: 0xDBD8D8)
    static let appGreen = UIColor(hex: 0x2EC715, a: 0.7)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
}
