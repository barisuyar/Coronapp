//
//  StringExtension.swift
//  GAforME
//
//  Created by Barış Uyar on 10.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    func getAttributed(rangeString: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: rangeString)
        let attribute = NSMutableAttributedString.init(string: self)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        attribute.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        return attribute
    }
    
    var doubleValue: Float? {
        if self.isEmpty {
            return 0
        } else {
            return NumberFormatter().number(from: self.replacingOccurrences(of: ",", with: ""))?.floatValue
        }
    }
}
