//
//  UILabel+Extensions.swift
//  GAforME
//
//  Created by Barış Uyar on 12.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit


public extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
    func adjustSpaceBetweenLines(text: String, lineSpacing: CGFloat = 2) {
        var attributedString: NSMutableAttributedString!
        if let atrString = getAttributedStringFromHtmlText(text: text) {
            attributedString = atrString
        } else {
            attributedString = NSMutableAttributedString(string: text)
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }

    
    
    private func getAttributedStringFromHtmlText(text: String) -> NSMutableAttributedString? {
        var attributedString: NSMutableAttributedString?
        guard let encodedData = text.data(using: String.Encoding.utf8) else { return attributedString }
        do {
            attributedString = try NSMutableAttributedString(data: encodedData, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
        } catch {
            return attributedString
        }
        return attributedString
    }
}
