//
//  KnowledgeViewController.swift
//  Coronapp
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common
import CoronaUI

protocol KnowledgeRouter: class {
    func showInfoPage(category: KnowledgeCategoryProtocol)
    func showSymptomsPage(category: KnowledgeCategoryProtocol)
}

protocol KnowledgeView: class {
    func reload()
}

class KnowledgeViewController: UIViewController {
    
    var presenter = KnowledgePresenter()
    
    @IBOutlet private weak var categoryCollectionView: UICollectionView! {
        didSet {
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
            categoryCollectionView.register(KnowledgeCategoryCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .backgroundColor
        categoryCollectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        presenter.createCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension KnowledgeViewController: KnowledgeView {
    func reload() {
        categoryCollectionView.reloadData()
    }
}

extension KnowledgeViewController: KnowledgeRouter {
    func showInfoPage(category: KnowledgeCategoryProtocol) {
        let viewController = InfoScreenModule.initModule(category: category)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSymptomsPage(category: KnowledgeCategoryProtocol) {
        let viewController = SymptomScreenModule.initModule(category: category)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension KnowledgeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.categoryCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let category = presenter.category(for: indexPath.row) else { return UICollectionViewCell() }
        let cell: KnowledgeCategoryCell = categoryCollectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = presenter.category(for: indexPath.row) else { return }
        if category.image != "symptom_icon_daily" {
            showInfoPage(category: category)
        } else {
            showSymptomsPage(category: category)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 35
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: 150)
    }
}
