//
//  QuaRequest.swift
//  Quarantine
//
//  Created by Barış Uyar on 27.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation

public class QuaRequest {
    
    let method: QuaMethod
    let path: String
    let payload: Data?
    
    public init(method: QuaMethod = .GET, path: String, payload: Data? = nil) {
        self.method = method
        self.path = path
        self.payload = payload
    }
    
    public init<T: Codable>(method: QuaMethod = .GET, path: String, payload: T? = nil) {
        self.method = method
        self.path = path
        do {
            self.payload = try JSONEncoder().encode(payload)
        } catch {
            self.payload = nil
        }
    }
}
