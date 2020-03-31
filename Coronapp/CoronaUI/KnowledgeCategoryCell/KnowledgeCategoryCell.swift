//
//  KnowledgeCategoryCell.swift
//  CoronaUI
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

public protocol KnowledgeCategoryProtocol {
    var image: String { get }
    var name: String { get }
}

public class KnowledgeCategoryCell: UICollectionViewCell, ReusableView, NibLoadableView {

    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel! {
        didSet {
            categoryLabel.textColor = .textColor
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .cardBackgroundColor
        roundCorners(.allCorners, radius: 20)
    }
    
    public func configure(with model: KnowledgeCategoryProtocol) {
        categoryImageView.image = UIImage(named: model.image)
        categoryLabel.text = model.name
    }

}
