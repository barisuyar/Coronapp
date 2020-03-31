//
//  ReusableView+NibLoadableView.swift
//  GAforME
//
//  Created by Barış Uyar on 12.11.2019.
//  Copyright © 2019 Barış Uyar. All rights reserved.
//

import UIKit

public protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: Self.self)
    }
}

public protocol NibLoadableView: class {
    static var nibName: String { get }
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
