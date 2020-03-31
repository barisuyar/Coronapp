//
//  SymptomScreenPresenter.swift
//  Coronapp
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import Foundation
import CoronaUI
import Common

class SymptomScreenPresenter {
    
    weak var view: SymptomScreenView?
    weak var router: SymptomScreenRouter?
    
    private var category: KnowledgeCategoryProtocol!
    private var generalSymptoms: [Info]!
    private var dailySymptoms: [Info]!
    
    private var decoder: LocalDecoderProtocol = LocalDecoder()
    
    private let segments = ["Gün Gün", "Genel"]
    private var selectedSegment: Int = 0
    var symptomsCount: Int {
        selectedSegment == 0 ? dailySymptoms.count : generalSymptoms.count
    }
    
    var segmentCount: Int {
        segments.count
    }
    
    var title: String {
        category.name
    }
    
    func segment(for index: Int) -> String {
        segments[index]
    }
    
    func change(segment: Int) {
        selectedSegment = segment
        view?.reload()
    }
    
    func info(for row: Int) -> Info? {
        guard row >= 0 else { return nil }
        if selectedSegment == 0 {
            guard row < dailySymptoms.count else { return nil }
            return dailySymptoms[row]
        } else {
            guard row < generalSymptoms.count else { return nil }
            return generalSymptoms[row]
        }
    }
    
    func set(category: KnowledgeCategoryProtocol) {
        self.category = category
    }
    
    func viewDidLoad() {
        let infos = decoder.decodeFromBundle(fileName: "infos", type: KnowdledgeList.self)
        self.generalSymptoms = infos?.knowledgeList.filter( { $0.category == "symptom_icon_general" } ).first?.infos ?? []
        self.dailySymptoms = infos?.knowledgeList.filter( { $0.category == "symptom_icon_daily" } ).first?.infos ?? []
        view?.reload()
    }
}
