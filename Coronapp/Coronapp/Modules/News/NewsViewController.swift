//
//  NewsViewController.swift
//  Coronapp
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import CoronaUI
import Common

protocol NewsRouter: class {
    
}

protocol NewsView: class {
    
}

class NewsViewController: UITableViewController {
    
    var presenter = NewsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewsCell.self)
        tableView.register(NewsShimmeringCell.self)
        view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        retrieveNews()
    }
    
    private func retrieveNews() {
        presenter.retrieveNews { [weak self] (response) in
            guard let self = self else { return }
            self.presenter.screenState = .loaded
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = presenter.newsCount
        if count <= 0 {
            tableView.backgroundView = TableViewEmptyListMessageView(message: "Corona Virüs ile ilgili haber bulunamadı.")
        } else {
            tableView.backgroundView = nil
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.screenState {
        case .loading:
            let cell: NewsShimmeringCell = tableView.dequeueReusableCell()
            cell.startShimmering()
            return cell
        case .loaded:
            guard let news = presenter.news(for: indexPath.row) else { return UITableViewCell() }
            let cell: NewsCell = tableView.dequeueReusableCell()
            cell.configure(with: news)
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = presenter.news(for: indexPath.row), let url = URL(string: news.url) else { return }
        UIApplication.shared.open(url)
    }
}

extension NewsViewController: NewsView {
    
}

extension NewsViewController: NewsRouter {
    
}
