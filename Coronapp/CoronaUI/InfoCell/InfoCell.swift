//
//  InfoCell.swift
//  CoronaUI
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

public protocol InfoProtocol {
    var title: String? { get }
    var description: String { get }
    var isShownSeperator: Bool? { get }
}

public class InfoCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .textColor
        }
    }
    @IBOutlet private weak var descriptionContainer: UIView! {
        didSet {
            descriptionContainer.backgroundColor = .cardBackgroundColor
            descriptionContainer.roundCorners(.allCorners, radius: 20)
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .textColor
        }
    }
    @IBOutlet private weak var seperator: UIImageView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    public func configure(with model: InfoProtocol) {
        titleLabel.text = model.title
        titleLabel.isHidden = model.title == nil
        
        descriptionLabel.text = model.description
        
        seperator.isHidden = !(model.isShownSeperator ?? false)
    }
}
