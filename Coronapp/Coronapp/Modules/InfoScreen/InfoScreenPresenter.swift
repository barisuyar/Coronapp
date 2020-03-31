//
//  InfoScreenPresenter.swift
//  Coronapp
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
import CoronaUI
import Common

class InfoScreenPresenter {
    
    weak var view: InfoScreenView?
    weak var router: InfoScreenRouter?
    
    private var category: KnowledgeCategoryProtocol!
    private var infoList: InfoList?
    private var decoder: LocalDecoderProtocol = LocalDecoder()
    
    var infoCount: Int {
        return infoList?.infos.count ?? 0
    }
    
    var title: String {
        return category.name
    }
    
    func set(category: KnowledgeCategoryProtocol) {
        self.category = category
    }
    
    func viewDidLoad() {
        let infos = decoder.decodeFromBundle(fileName: "infos", type: KnowdledgeList.self)
        self.infoList = infos?.knowledgeList.filter({ $0.category == category.image }).first
        view?.reload()
    }
    
    func info(for row: Int) -> Info? {
        guard row >= 0, row < infoList?.infos.count ?? 0 else { return nil }
        return infoList?.infos[row]
    }
}



struct Info: Codable, InfoProtocol {
    var title: String?
    var description: String
    var isShownSeperator: Bool? = false
}

struct InfoList: Codable {
    var category: String
    var infos: [Info]
}

struct KnowdledgeList: Codable {
    var knowledgeList: [InfoList]
}
