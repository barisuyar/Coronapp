//
//  InfoScreenViewController.swift
//  Coronapp
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import CoronaUI
import Common

protocol InfoScreenRouter: class {
    
}

protocol InfoScreenView: class {
    func reload()
}

class InfoScreenViewController: UITableViewController {
    
    var presenter = InfoScreenPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = presenter.title
        
        view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .none
        
        tableView.register(InfoCell.self)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        presenter.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.infoCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let info = presenter.info(for: indexPath.row) else { return UITableViewCell() }
        let cell: InfoCell = tableView.dequeueReusableCell()
        cell.configure(with: info)
        return cell
    }
}

extension InfoScreenViewController: InfoScreenView {
    func reload() {
        tableView.reloadData()
    }
}

extension InfoScreenViewController: InfoScreenRouter {
    
}
