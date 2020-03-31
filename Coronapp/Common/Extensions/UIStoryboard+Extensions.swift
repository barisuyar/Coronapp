//
//  UIStoryboard+Extensions.swift
//  GAforME
//
//  Created by Barış Uyar on 10.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    
    class func instantiateViewController<T: UIViewController>(_ storyboardName: String, _: T.Type) -> T? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as? T
    }
    
    class func instantiateViewController<T: UIViewController>(_ storyboardName: String, clazz: AnyClass) -> T? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: clazz)) as? T
    }
    
    class func instantiateViewController<T: UIViewController>(_ storyboardName: String, identifier: String) -> T? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T
    }
}
