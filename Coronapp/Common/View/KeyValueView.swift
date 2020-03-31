//
//  KeyValueView.swift
//  GAforME
//
//  Created by Barış Uyar on 12.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit

public class KeyValueView: UIView {
    
    private var keyLabel: UILabel!
    private var valueLabel: UILabel!
    private var keyLabelLeadingConstraint: NSLayoutConstraint!
    private var valueLabelTrailingConstraint: NSLayoutConstraint!
    
    public var key: String = "" {
        didSet {
            keyLabel.text = key
        }
    }
    
    public var value: String = "" {
        didSet {
            valueLabel.text = value
        }
    }
    public var leftAnchorConstant: CGFloat = 16 {
        didSet {
            keyLabelLeadingConstraint.constant = leftAnchorConstant
            layoutIfNeeded()
        }
    }
    
    public var rightAnchorConstant: CGFloat = 16 {
        didSet {
            valueLabelTrailingConstraint.constant = -rightAnchorConstant
            layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    internal func setup() {
        keyLabel = UILabel()
        keyLabel.font = UIFont.systemFont(ofSize: 15)
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(keyLabel)
        keyLabelLeadingConstraint = keyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftAnchorConstant)
        keyLabelLeadingConstraint.isActive = true
        keyLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        keyLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        valueLabel = UILabel()
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        addSubview(valueLabel)
        valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: keyLabel.trailingAnchor, constant: 15).isActive = true
        valueLabelTrailingConstraint = valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -rightAnchorConstant)
        valueLabelTrailingConstraint.isActive = true
        valueLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.backgroundColor = .clear
    }
    
}
