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
            searchTextField.delegate = self
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        addToolbar()
    }
    
    public func set(textChangeHandler: Handler<String?>?) {
        self.textChangeHandler = textChangeHandler
    }
    
    @objc private func textfieldEditingChanged() {
        textChangeHandler?(searchTextField.text)
    }
    
    func addToolbar() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let constraint = toolbar.heightAnchor.constraint(equalToConstant: 45)
        constraint.isActive = true

        let barButtonItem = UIBarButtonItem(title: "Kapat", style: .done, target: target, action: #selector(resign))
        barButtonItem.tintColor = UIColor.textColor
        
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            barButtonItem
        ]
        toolbar.sizeToFit()
        searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func resign() {
        searchTextField.resignFirstResponder()
    }
}

extension SearchField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}
