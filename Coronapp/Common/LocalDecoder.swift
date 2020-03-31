//
//  LocalDecoder.swift
//  Common
//
//  Created by Barış Uyar on 31.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation

public protocol LocalDecoderProtocol {
    func decodeFromBundle<T: Codable>(fileName: String, type: T.Type) -> T?
}

public class LocalDecoder: LocalDecoderProtocol {
    
    public init() {
    }
    
    public func decodeFromBundle<T: Codable>(fileName: String, type: T.Type) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch(let error) {
                print(error)
                return nil
            }
        }
        return nil
    }
}
