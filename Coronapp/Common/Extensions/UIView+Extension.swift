//
//  UIView+Extension.swift
//  Common
//
//  Created by Barış Uyar on 28.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit

public extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
    func startShimmering() {
        
        if let _ = layer.mask?.animation(forKey: "shimmer") {
            return
        }
        
        let light = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.5).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, light, alpha]
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.4, 0.5, 0.6]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering() {
        self.layer.mask = nil
    }
}
