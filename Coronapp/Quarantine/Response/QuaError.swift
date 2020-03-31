//
//  QuaError.swift
//  Quarantine
//
//  Created by Barış Uyar on 27.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation

public enum QuaError: Error {
    case network
    case badURL(url: String)
    case decoding(reason: String?)
    case business(reason: String)
    case unauthorized
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data."
        case .badURL(let url):
            return "\(url) is not exist."
        case .decoding(let reason):
            guard let reason = reason else { return "An error occurred while decoding data." }
            return reason
        case .business(let reason):
            return reason
        case .unauthorized:
            return "An error occured cause there is no apikey"
        }
    }
}
