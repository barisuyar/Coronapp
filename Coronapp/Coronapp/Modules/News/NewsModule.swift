//
//  NewsModule.swift
//  Coronapp
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit

class NewsModule {
    
    static func initModule() -> UIViewController {
        let viewController = NewsViewController()
        
        viewController.presenter.view = viewController
        viewController.presenter.router = viewController
        return viewController
    }
    
}
