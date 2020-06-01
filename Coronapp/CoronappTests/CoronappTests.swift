//
//  CoronappTests.swift
//  CoronappTests
//
//  Created by Barış Uyar on 26.05.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import XCTest
@testable import Coronapp

class CoronappTests: XCTestCase {
    
    var presenter: CaseVisualizePresenter!

    override func setUp() {
        presenter = CaseVisualizePresenter(resource: MockCoronaCasesResource())
    }
    
    func testCountries() {
        presenter.retrieveCountries { [weak self] (error) in
            guard let self = self else { return }
            XCTAssertNil(error)
            XCTAssertEqual(self.presenter.screenState, CaseVisualizePresenter.ScreenState.loaded)
            XCTAssertEqual(self.presenter.countryCount, 2)
            XCTAssertNotEqual(self.presenter.country(for: 0)?.totalCases.doubleValue, 0)
            XCTAssertNotEqual(self.presenter.country(for: 1)?.totalCases.doubleValue, 0)
            XCTAssertGreaterThanOrEqual(self.presenter.country(for: 0)?.totalCases.doubleValue ?? 0, self.presenter.country(for: 1)?.totalCases.doubleValue ?? 0)
        }
    }

    func testTotal() {
        presenter.retrieveTotal { (result) in
            switch result {
            case .failure(_):
                break
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertTrue(response?.success ?? false)
            }
        }
    }
}
