//
//  MockCoronaCasesResource.swift
//  CoronappTests
//
//  Created by Barış Uyar on 26.05.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
@testable import Coronapp
@testable import Common
@testable import Quarantine

final class MockCoronaCasesResource: CoronaCasesResourceProtocol {
    
    var countryResponse: CountryResponse?
    var totalResponse: TotalResponse?
    let decoder: LocalDecoderProtocol = LocalDecoder()
    
    func retrieveCountries(completion: @escaping Handler<Result<CountryResponse?, QuaError>>) {
        countryResponse = decoder.decodeFromBundle(fileName: "countries", type: CountryResponse.self)
        completion(.success(countryResponse))
    }
    
    func retrieveTotal(completion: @escaping Handler<Result<TotalResponse?, QuaError>>) {
        totalResponse = LocalDecoder().decodeFromBundle(fileName: "totalData", type: TotalResponse.self)
        completion(.success(totalResponse))
    }
}
