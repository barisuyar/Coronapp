//
//  Filtered.swift
//  Common
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation

public protocol Filterable {
    var filterString : String { get }
}

@propertyWrapper
public struct Filtered<T> where T: Filterable {
    
    public var filterString: String
    public var wrappedValue:[T]
    
    public var filtered:[T] {
        if filterString.count > 0 {
            return wrappedValue.filter({
                $0.filterString.lowercased().range(of: filterString, options: .caseInsensitive) != nil
            })
        }
        return wrappedValue
    }

    public init(filterString : String) {
        self.wrappedValue = [] as! [T]
        self.filterString = filterString
    }
}
