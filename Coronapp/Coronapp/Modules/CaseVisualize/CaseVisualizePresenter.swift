//
//  CaseVisualizePresenter.swift
//  Coronapp
//
//  Created by Barış Uyar on 28.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
import CoronaUI
import Quarantine
import Common

class CaseVisualizePresenter {
    
    weak var view: CaseVisualizeView?
    weak var router: CaseVisualizeRouter?
    
    enum ScreenState {
        case loading
        case loaded
    }
    
    private var resource: CoronaCasesResourceProtocol!
    @Filtered(filterString: "") private var countryArray: [Country]
    private var countryResponse: CountryResponse?
    private var filteredCountryResponse: CountryResponse?
    var screenState: ScreenState = .loading
    
    var countryCount: Int {
        screenState == .loading ? 5 : _countryArray.filtered.count
    }
    
    init(resource: CoronaCasesResourceProtocol) {
        self.resource = resource
    }
    
    func country(for row: Int) -> CountryProtocol? {
        guard row >= 0, row < _countryArray.filtered.count else { return nil }
        return _countryArray.filtered[row]
    }
    
    func retrieveTotal(completion: @escaping Handler<Result<TotalResponse?, QuaError>>) {
        resource.retrieveTotal { (result) in
            completion(result)
        }
    }
    
    func retrieveCountries(completion: @escaping Handler<QuaError?>) {
        resource.retrieveCountries { [weak self] (result) in
            guard let self = self else { return }
            self.screenState = .loaded
            switch result {
            case .success(let response):
                if let countries = response?.result {
                    let sortedArray = countries.sorted(by: { (ct1, ct2) -> Bool in
                        let ct1Double = ct1.totalCases.doubleValue ?? 0
                        let ct2Double = ct2.totalCases.doubleValue ?? 0
                        return ct1Double > ct2Double
                    })
                    self.countryArray = sortedArray
                } else { self.countryArray = [] }
                completion(nil)
            case .failure(let error):
                self.countryResponse = nil
                completion(error)
            }
        }
    }
    
    func search(text: String?) {
        _countryArray.filterString = text ?? ""
        view?.reloadTableView()
    }
}

struct Total: Codable, TotalProtocol {
    var totalCases: String
    var totalDeaths: String
    var totalRecovered: String
}

struct TotalResponse: Codable {
    var success: Bool
    var result: Total
}

struct Country: Codable, CountryProtocol {
    let country: String
    let totalCases: String
    let newCases: String
    let totalDeaths: String
    let newDeaths: String
    let totalRecovered: String
    let activeCases: String
}

extension Country: Filterable {
    var filterString: String {
        country.lowercased()
    }
}

struct CountryResponse: Codable {
    var result: [Country]?
    let success: Bool
}

protocol CoronaCasesResourceProtocol: QuaResponse {
    func retrieveCountries(completion: @escaping Handler<Result<CountryResponse?, QuaError>>)
    func retrieveTotal(completion: @escaping Handler<Result<TotalResponse?, QuaError>>)
}

class CoronaCasesResource: CoronaCasesResourceProtocol {
    init() {
    }
    
    func retrieveCountries(completion: @escaping Handler<Result<CountryResponse?, QuaError>>) {
        retrieve(QuaRequest(method: .GET, path: "https://api.collectapi.com/corona/countriesData", payload: nil)) { (result) in
            completion(result)
        }
    }
    
    func retrieveTotal(completion: @escaping Handler<Result<TotalResponse?, QuaError>>) {
        retrieve(QuaRequest(method: .GET, path: "https://api.collectapi.com/corona/totalData", payload: nil)) { (result) in
            completion(result)
        }
    }
}


