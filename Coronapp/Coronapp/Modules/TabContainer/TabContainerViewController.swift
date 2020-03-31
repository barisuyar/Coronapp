//
//  TabContainerViewController.swift
//  Coronapp
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit

protocol TabContainerRouter: class {
    
}

protocol TabContainerView: class {
    
}

class TabContainerViewController: UITabBarController {
    
    var presenter = TabContainerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension TabContainerViewController: TabContainerView {
    
}

extension TabContainerViewController: TabContainerRouter {
    
}
