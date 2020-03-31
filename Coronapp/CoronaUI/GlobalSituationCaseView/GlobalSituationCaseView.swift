//
//  GlobalSituationCaseView.swift
//  CoronaUI
//
//  Created by Barış Uyar on 28.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Common
import UIKit

public protocol GlobalCaseProtocol {
    var caseName: String? { get }
    var caseCount: String? { get }
    var totalCaseCount: String? { get }
    var caseType: CaseType { get }
}

public enum CaseType {
    case confirmed
    case dead
    case recover
}

public class GlobalSituationCaseView: NibView {
    
    @IBOutlet private weak var caseDot: UIView! {
        didSet {
            caseDot.roundCorners(.allCorners, radius: 6)
        }
    }
    @IBOutlet private weak var caseNameLabel: UILabel! {
        didSet {
            caseNameLabel.textColor = .textColor
        }
    }
    @IBOutlet private weak var caseCountLabel: UILabel! {
        didSet {
            caseCountLabel.textColor = .textColor
        }
    }
    @IBOutlet private weak var caseProgress: UIView! {
        didSet {
            caseProgress.roundCorners(.allCorners, radius: 4)
        }
    }
    @IBOutlet private weak var caseRatio: UILabel! {
        didSet {
            caseRatio.isHidden = true
            caseRatio.textColor = .appRed
        }
    }
    @IBOutlet weak var caseProgressStackView: UIStackView!
    
    public func configure(with model: GlobalCaseProtocol) {
        let color: UIColor!
        switch model.caseType {
        case .confirmed:
            color = .appOrange
        case .dead:
            color = .appRed
            caseRatio.isHidden = false
        case .recover:
            color = .appCyan
        }
        caseDot.backgroundColor = color
        caseProgress.backgroundColor = color
        caseNameLabel.text = model.caseName
        caseCountLabel.text = model.caseCount
        
        if let caseFloat = (model.caseCount as NSString?)?.floatValue,
            let totalFloat = (model.totalCaseCount as NSString?)?.floatValue {
            caseProgress.translatesAutoresizingMaskIntoConstraints = false
            let ratio = caseFloat / totalFloat
            caseProgress.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: CGFloat(ratio)).isActive = true
            if case .dead = model.caseType {
                caseRatio.text = String(format: "%.2f", ratio * 100)
            }
        } else {
            caseProgressStackView.isHidden = true
        }
    }
}
