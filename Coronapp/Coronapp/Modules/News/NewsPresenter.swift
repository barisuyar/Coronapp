//
//  NewsPresenter.swift
//  Coronapp
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
import CoronaUI
import Quarantine
import Common

class NewsPresenter {
    
    weak var view: NewsView?
    weak var router: NewsRouter?
    
    enum ScreenState {
        case loading
        case loaded
    }
    
    private var resource: CoronaNewsResourceProtocol = CoronaNewsResource()
    private var news: [News]?
    var screenState: ScreenState = .loading
    
    var newsCount: Int {
        screenState == .loading ? 5 : news?.count ?? 0
    }
    
    func news(for row: Int) -> NewsProtocol? {
        guard row >= 0, row < news?.count ?? 0 else { return nil }
        return news?[row]
    }
    
    func retrieveNews(completion: @escaping Handler<QuaError?>) {
        resource.retrieveNews { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.news = response?.result
                completion(nil)
            case .failure(let error):
                self.news = nil
                completion(error)
            }
        }
    }
}

struct News: NewsProtocol, Codable {
    var date: String
    var url: String
    var description: String
    var image: String
    var name: String
    var source: String
}

struct NewsResponse: Codable {
    let success: Bool
    let result: [News]?
}

protocol CoronaNewsResourceProtocol: QuaResponse {
    func retrieveNews(completion: @escaping Handler<Result<NewsResponse?, QuaError>>)
}

class CoronaNewsResource: CoronaNewsResourceProtocol {
    func retrieveNews(completion: @escaping Handler<Result<NewsResponse?, QuaError>>) {
        retrieve(QuaRequest(method: .GET, path: "https://api.collectapi.com/corona/coronaNews", payload: nil)) { (result) in
            completion(result)
        }
    }
}
