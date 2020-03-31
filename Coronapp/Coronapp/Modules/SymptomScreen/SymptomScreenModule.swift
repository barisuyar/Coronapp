//
//  SymptomScreenModule.swift
//  Coronapp
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import CoronaUI

class SymptomScreenModule {
    
    static func initModule(category: KnowledgeCategoryProtocol) -> UIViewController {
        guard let viewController = UIStoryboard.instantiateViewController("Main", SymptomScreenViewController.self) else {
            fatalError("Couldn't iniatialize SymptomScreenViewController from storyboard")
        }
        viewController.presenter.view = viewController
        viewController.presenter.router = viewController
        
        viewController.presenter.set(category: category)
        
        viewController.hidesBottomBarWhenPushed = true
        
        return viewController
    }
    
}
