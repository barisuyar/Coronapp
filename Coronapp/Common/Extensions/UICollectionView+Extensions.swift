//
//  UICollectionView+Extensions.swift
//  Common
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type, forSupplementaryViewOfKind: String) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        self.register(nib, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(kind ofKind: String, indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
