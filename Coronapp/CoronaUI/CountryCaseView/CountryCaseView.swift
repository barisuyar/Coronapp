//
//  CountryCaseView.swift
//  CoronaUI
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

public protocol CountryCaseProtocol {
    var totalCase: String { get }
    var newCase: String { get }
    var type: CaseType { get }
}

public class CountryCaseView: NibView {
    
    @IBOutlet private weak var dotView: UIView! {
        didSet {
            dotView.roundCorners(.allCorners, radius: 6)
        }
    }
    @IBOutlet private weak var totalCase: UILabel! {
        didSet {
            totalCase.textColor = .cardBackgroundColor
        }
    }
    @IBOutlet private weak var newCase: UILabel! {
        didSet {
            newCase.textColor = .cardBackgroundColor
        }
    }
    
    @IBOutlet weak var placeholderView: UIView! {
        didSet {
            placeholderView.backgroundColor = .textColor
            placeholderView.roundCorners(.allCorners, radius: 10)
        }
    }
    
    public override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model: CountryCaseProtocol) {
        totalCase.text = model.totalCase.isEmpty ? "0" : model.totalCase
        switch model.type {
        case .confirmed:
            newCase.isHidden = false
            newCase.textColor = .appOrange
            newCase.text = model.newCase
            dotView.backgroundColor = .appOrange
        case .dead:
            newCase.isHidden = false
            newCase.textColor = .appRed
            newCase.text = model.newCase
            dotView.backgroundColor = .appRed
        case .recover:
            newCase.isHidden = true
            dotView.backgroundColor = .appCyan
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 50)
    }
}
