//
//  QuaClient.swift
//  Quarantine
//
//  Created by Barış Uyar on 27.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
import Common

protocol QuaClientProtocol {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T?, QuaError>>)
}

public class QuaClient: QuaClientProtocol {
    func retrieve<T: Codable>(_ request: QuaRequest, completion: @escaping Handler<Result<T?, QuaError>>) {
        
        if let url = NSURL(string: request.path) as URL? {
            let headers = [
                "content-type": "application/json",
                "authorization": "apikey 2kOGC0iJfy4MAJAX5aM7N6:4AVcNllLNhINRhlHKdd9Va"
            ]
            let httpRequest = NSMutableURLRequest(url: url,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 90.0)
            httpRequest.httpMethod = request.method.rawValue
            httpRequest.allHTTPHeaderFields = headers
            httpRequest.httpBody = request.payload
            
            let dataTask = session.dataTask(with: httpRequest as URLRequest, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                        completion(Result.failure(QuaError.unauthorized))
                        return
                    }
                    do {
                        if let data = data {
                            print(String(decoding: data, as: UTF8.self))
                            let result = try JSONDecoder().decode(T.self, from: data)
                            completion(Result.success(result))
                        } else {
                            completion(Result.success(nil))
                        }
                    } catch(let error) {
                        completion(Result.failure(QuaError.decoding(reason: error.localizedDescription)))
                    }
                }
            })
            dataTask.resume()
        } else {
            completion(Result.failure(QuaError.badURL(url: request.path)))
        }
        
    }
    
    
    public static let shared = QuaClient()
    private let queue = DispatchQueue(label: "bu.qua.client", qos: .utility, attributes: [.concurrent])
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}
