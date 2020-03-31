//
//  CaseVisualizeViewController.swift
//  Coronapp
//
//  Created by Barış Uyar on 28.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import CoronaUI
import Common

protocol CaseVisualizeRouter: class {
    
}

protocol CaseVisualizeView: class {
    func reloadTableView()
}

class CaseVisualizeViewController: UIViewController {
    
    var presenter = CaseVisualizePresenter()
    
    @IBOutlet private weak var globalSituationPlaceholder: UIView! {
        didSet {
            globalSituationPlaceholder.backgroundColor = .backgroundColor
            globalSituationPlaceholder.roundCorners(.allCorners, radius: 20)
        }
    }
    @IBOutlet private weak var globalSituationView: GlobalSituationView!
    @IBOutlet private weak var searchField: SearchField! {
        didSet {
            searchField.backgroundColor = .cardBackgroundColor
            searchField.roundCorners(.allCorners, radius: 10)
            searchField.set { [weak self] (searchedText) in
                self?.search(text: searchedText)
            }
            searchField.isHidden = true
        }
    }
    @IBOutlet private weak var countriesTableView: UITableView! {
        didSet {
            countriesTableView.dataSource = self
        }
    }
    
    private var dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: false)
        initialCalls()
        countriesTableView.register(CountryCaseCell.self)
        countriesTableView.register(ShimmeringCell.self)
    }
    
    private func initialCalls() {
        retrieveTotalCases()
        retrieveCountryCases()
        
        dispatchGroup.notify(queue: .main) {
            
        }
    }
    
    private func retrieveTotalCases() {
        dispatchGroup.enter()
        self.globalSituationView.isHidden = true
        self.globalSituationPlaceholder.isHidden = false
        self.globalSituationPlaceholder.startShimmering()
        presenter.retrieveTotal { [weak self] (result) in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .success(let response):
                guard let totalCases = response else { return }
                self.globalSituationPlaceholder.isHidden = true
                self.globalSituationView.configure(with: totalCases.result)
                self.globalSituationView.isHidden = false
            case .failure(_):
                self.globalSituationView.isHidden = true
                self.globalSituationView.isHidden = true
            }
        }
    }
    
    private func retrieveCountryCases() {
        dispatchGroup.enter()
        presenter.retrieveCountries { [weak self] (result) in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            self.presenter.screenState = .loaded
            self.searchField.isHidden = false
            self.countriesTableView.reloadData()
        }
    }
    
    private func search(text: String?) {
        presenter.search(text: text)
    }
}

extension CaseVisualizeViewController: CaseVisualizeView {
    func reloadTableView() {
        countriesTableView.reloadData()
    }
}

extension CaseVisualizeViewController: CaseVisualizeRouter {
    
}

extension CaseVisualizeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = presenter.countryCount
        if count <= 0 {
            tableView.backgroundView = TableViewEmptyListMessageView(message: "Ülkeler bazında Corona Virüs verilerine ulaşılamadı.")
        } else {
            tableView.backgroundView = nil
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.screenState {
        case .loading:
            let cell: ShimmeringCell = tableView.dequeueReusableCell()
            cell.startShimmering()
            return cell
        case .loaded:
            guard let country = presenter.country(for: indexPath.row) else { return UITableViewCell() }
            let cell: CountryCaseCell = tableView.dequeueReusableCell()
            cell.configure(with: country)
            return cell
        }
    }
}
