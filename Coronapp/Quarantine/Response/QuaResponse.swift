//
//  QuaResponse.swift
//  Quarantine
//
//  Created by Barış Uyar on 27.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
import Common

public protocol QuaResponse {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T?, QuaError>>)
}

public extension QuaResponse {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T?, QuaError>>) {
        QuaClient.shared.retrieve(request) { (result) in
            completion(result)
        }
    }
}
