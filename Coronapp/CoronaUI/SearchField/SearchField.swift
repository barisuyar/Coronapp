//
//  SearchField.swift
//  CoronaUI
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

public class SearchField: NibView {
    
    private enum Constants {
        static let countries: String = "Ülkeler"
    }
    
    private var textChangeHandler: Handler<String?>?
    
    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.countries,
                                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.appLightTextColor])
            searchTextField.textColor = .textColor
            searchTextField.addTarget(self, action: #selector(textfieldEditingChanged), for: .editingChanged)
        }
    }
    
    public func set(textChangeHandler: Handler<String?>?) {
        self.textChangeHandler = textChangeHandler
    }
    
    @objc private func textfieldEditingChanged() {
        textChangeHandler?(searchTextField.text)
    }
}
