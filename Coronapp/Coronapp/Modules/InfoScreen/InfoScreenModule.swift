//
//  InfoScreenModule.swift
//  Coronapp
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import CoronaUI

class InfoScreenModule {
    
    static func initModule(category: KnowledgeCategoryProtocol) -> UIViewController {
        let viewController = InfoScreenViewController()
        
        viewController.presenter.view = viewController
        viewController.presenter.router = viewController
        
        viewController.presenter.set(category: category)
        viewController.hidesBottomBarWhenPushed = true
        
        return viewController
    }
    
}
