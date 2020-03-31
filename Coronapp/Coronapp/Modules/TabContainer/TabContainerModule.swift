//
//  TabContainerModule.swift
//  Coronapp
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit

class TabContainerModule {
    
    static func initModule() -> UIViewController {
        let viewController = TabContainerViewController()
        
        viewController.presenter.view = viewController
        viewController.presenter.router = viewController
        
        let caseVisualize = CaseVisualizeModule.initModule()
        let news = NewsModule.initModule()
        let knowledge = UINavigationController(rootViewController: KnowledgeModule.initModule()) 
         
        caseVisualize.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "graphic")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "selectedGraphic")?.withRenderingMode(.alwaysOriginal))
        news.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "news")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "selectedNews")?.withRenderingMode(.alwaysOriginal))
        knowledge.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "knowledge")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "selectedKnowledge")?.withRenderingMode(.alwaysOriginal))
        
        viewController.viewControllers = [caseVisualize, news, knowledge]
        viewController.selectedIndex = 0
        
        return viewController
    }
    
}
