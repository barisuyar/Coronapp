//
//  KnowledgePresenter.swift
//  Coronapp
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
import CoronaUI

class KnowledgePresenter {
    
    weak var view: KnowledgeView?
    weak var router: KnowledgeRouter?
    
    private var categories: [KnowledgeCategory] = []
    
    var categoryCount: Int {
        return categories.count
    }
    
    func category(for row: Int) -> KnowledgeCategoryProtocol? {
        guard row >= 0, row < categories.count else { return nil }
        return categories[row]
    }
    
    func createCategories() {
        categories.append(KnowledgeCategory(image: "virus_icon", name: "Virüs"))
        categories.append(KnowledgeCategory(image: "mask_icon", name: "Maske"))
        categories.append(KnowledgeCategory(image: "advice_icon", name: "Öneriler"))
        categories.append(KnowledgeCategory(image: "symptom_icon_daily", name: "Semptomlar"))
        categories.append(KnowledgeCategory(image: "myth_icon", name: "Mitler"))
        view?.reload()
    }
}

struct KnowledgeCategory: KnowledgeCategoryProtocol {
    var image: String
    var name: String
}
