//
//  CountryCaseCell.swift
//  CoronaUI
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

public protocol CountryProtocol {
    var country: String { get }
    var totalCases: String { get }
    var newCases: String { get }
    var totalDeaths: String { get }
    var newDeaths: String { get }
    var totalRecovered: String { get }
    var activeCases: String { get }
}

private struct CountryCase: CountryCaseProtocol {
    var totalCase: String
    var newCase: String
    var type: CaseType
}

public class CountryCaseCell: UITableViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var confirmedView: CountryCaseView!
    @IBOutlet private weak var recoverView: CountryCaseView!
    @IBOutlet private weak var deadView: CountryCaseView!
    @IBOutlet private weak var countryNameLabel: UILabel! {
        didSet {
            countryNameLabel.numberOfLines = 0
            countryNameLabel.textColor = .textColor
        }
    }
    @IBOutlet private weak var countryInfoView: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        countryInfoView.backgroundColor = .cardBackgroundColor
        countryInfoView.roundCorners(.allCorners, radius: 10)
        selectionStyle = .none
    }
    
    public func configure(with model: CountryProtocol) {
        countryNameLabel.text = model.country
        confirmedView.configure(with: CountryCase(totalCase: model.totalCases, newCase: model.newCases, type: .confirmed))
        recoverView.configure(with: CountryCase(totalCase: model.totalRecovered, newCase: "", type: .recover))
        deadView.configure(with: CountryCase(totalCase: model.totalDeaths, newCase: model.newDeaths, type: .dead))
    }
    
}
