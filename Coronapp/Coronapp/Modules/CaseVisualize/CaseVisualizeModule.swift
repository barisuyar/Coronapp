//
//  CaseVisualizeModule.swift
//  Coronapp
//
//  Created by Barış Uyar on 28.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

class CaseVisualizeModule {
    
    static func initModule() -> UIViewController {
        guard let viewController = UIStoryboard.instantiateViewController("Main", CaseVisualizeViewController.self) else {
            fatalError("Couldn't iniatialize CaseVisualizeViewController from storyboard")
        }
        viewController.presenter.view = viewController
        viewController.presenter.router = viewController
        return viewController
    }
    
}
