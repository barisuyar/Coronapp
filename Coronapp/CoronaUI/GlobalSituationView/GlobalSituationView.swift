//
//  GlobalSituationView.swift
//  CoronaUI
//
//  Created by Barış Uyar on 28.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

public protocol TotalProtocol {
    var totalCases: String { get }
    var totalDeaths: String { get }
    var totalRecovered: String { get }
}

public class GlobalSituationView: NibView {
    
    private enum Constants {
        static let globalText: String = "Küresel Durum"
        static let confirmText: String = "Vaka"
        static let recoverText: String = "Kurtarılan"
        static let deadText: String = "Ölüm"
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .textColor
            titleLabel.text = Constants.globalText
        }
    }
    @IBOutlet private weak var confirmView: GlobalSituationCaseView!
    @IBOutlet private weak var recoverView: GlobalSituationCaseView!
    @IBOutlet private weak var deadView: GlobalSituationCaseView!
    @IBOutlet private weak var lastUpdateLabel: UILabel! {
        didSet {
            lastUpdateLabel.textColor = .appLightTextColor
        }
    }
    @IBOutlet weak var casesView: UIView! {
        didSet {
            casesView.roundCorners(.allCorners, radius: 20)
            casesView.backgroundColor = .cardBackgroundColor
        }
    }
    
    private var todayString: String {
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute], from: date)

        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute

        let todayString = String(day!) + "/" + String(month!) + "/" + String(year!) + " " + String(hour!) + ":" + String(minute!)

        return todayString
    }
    
    private struct GlobalSituationCase: GlobalCaseProtocol {
        var caseName: String?
        var caseCount: String?
        var totalCaseCount: String?
        var caseType: CaseType
    }
    
    public func configure(with model: TotalProtocol) {
        confirmView.configure(with: GlobalSituationCase(caseName: Constants.confirmText, caseCount: model.totalCases, totalCaseCount: model.totalCases, caseType: .confirmed))
        recoverView.configure(with: GlobalSituationCase(caseName: Constants.recoverText, caseCount: model.totalRecovered, totalCaseCount: model.totalCases, caseType: .recover))
        deadView.configure(with: GlobalSituationCase(caseName: Constants.deadText, caseCount: model.totalDeaths, totalCaseCount: model.totalCases, caseType: .dead))
        lastUpdateLabel.text = "Son Güncelleme: " + todayString
    }
}
