//
//  SymptomScreenViewController.swift
//  Coronapp
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import CoronaUI

protocol SymptomScreenRouter: class {
    
}

protocol SymptomScreenView: class {
    func reload()
}

class SymptomScreenViewController: UIViewController {
    
    var presenter = SymptomScreenPresenter()
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.tintColor = .cardBackgroundColor
            segmentedControl.selectedSegmentTintColor = .textColor
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.cardBackgroundColor,
                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .selected)
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textColor,
                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: .normal)
        }
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction private func segmentedControlValuChanged(_ sender: UISegmentedControl) {
        presenter.change(segment: sender.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = presenter.title
        
        view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        tableView.register(InfoCell.self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension SymptomScreenViewController: SymptomScreenView {
    func reload() {
        tableView.reloadData()
    }
}

extension SymptomScreenViewController: SymptomScreenRouter {
    
}

extension SymptomScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.symptomsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let info = presenter.info(for: indexPath.row) else { return UITableViewCell() }
        let cell: InfoCell = tableView.dequeueReusableCell()
        cell.configure(with: info)
        return cell
    }
}
