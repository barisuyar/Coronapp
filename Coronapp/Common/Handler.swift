//
//  Handler.swift
//  Common
//
//  Created by Barış Uyar on 27.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation

public typealias Handler<T> = ((T) -> Void)
public typealias DoubleHandler<T, U> = ((T, U) -> Void)

public typealias VoidHandler = () -> Void
public typealias BoolHandler = Handler<Bool>
public typealias StringHandler = Handler<String>
public typealias IntHandler = Handler<Int>
