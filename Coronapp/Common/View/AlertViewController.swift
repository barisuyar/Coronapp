//
//  AlertView.swift
//  GAforME
//
//  Created by Barış Uyar on 14.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit

public class AlertViewController: UIViewController {
    
    public class func newInstance(message: String?) -> AlertViewController {
        let vc = AlertViewController(nibName: "AlertViewController", bundle: Bundle(for: AlertViewController.self))
        vc.message = message
        return vc
    }
    
    private static var MAX_WIDTH: CGFloat = 206
    private static var MIN_HEIGHT: CGFloat = 343
    
    private var message: String?
    fileprivate var actions = Dictionary<Int, (AnyObject, Action)>()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textLabel: UILabel! {
        didSet {
            textLabel.numberOfLines = 0
            textLabel.lineBreakMode = .byWordWrapping
        }
    }

    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.layer.cornerRadius = 10
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textLabel.text = self.message
        for i in 0..<actions.keys.count {
            if let button = actions[i]?.0 as? UIView {
                stackView.addArrangedSubview(button)
            }
        }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
    }
    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func add(_ action: Action) {
        let button = UIButton()
        button.setTitle(action.title, for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        button.tag = actions.keys.count
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        actions[actions.keys.count] = (button, action)
    }
    
    @objc fileprivate func buttonClicked(_ sender: AnyObject?) {
        if let tag = sender?.tag, let (_, action) = actions[tag] {
            self.dismiss(animated: true) {
                action.handler?(action)
            }
        }
    }
}

public class Action {
    
    var title: String?
    var handler: ((Action) -> Void)?
    
    public init(title: String?, handler: ((Action) -> Void)? = nil) {
        self.title = title
        self.handler = handler
    }
}

public protocol AlertView {
    func showAlert(message: String, actions: Action...)
}
