//
//  NibView.swift
//  GAforME
//
//  Created by Barış Uyar on 12.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit

open class NibView: UIView, NibLoadableView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        guard let className = String(describing: self.classForCoder).components(separatedBy: ".").last else { return }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.backgroundColor = UIColor.clear
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: .equal, toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: .equal, toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: .equal, toItem: self,
                                              attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
    }
}
