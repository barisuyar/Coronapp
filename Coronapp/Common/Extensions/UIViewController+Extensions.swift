//
//  UIViewController+Extensions.swift
//  GAforME
//
//  Created by Barış Uyar on 14.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit

extension UIViewController: AlertView {
    public func showAlert(message: String, actions: Action...) {
        let vc = AlertViewController.newInstance(message: message)
        actions.forEach { (action) in
            vc.add(action)
        }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}
