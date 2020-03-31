//
//  NewsCell.swift
//  CoronaUI
//
//  Created by Barış Uyar on 29.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit
import Common

public protocol NewsProtocol {
    var date: String { get }
    var url: String { get }
    var description: String { get }
    var image: String { get }
    var name: String { get }
    var source: String { get }
}

public class NewsCell: UITableViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var sourceLabel: UILabel! {
        didSet {
            sourceLabel.textColor = .cardBackgroundColor
        }
    }
    @IBOutlet private weak var sourceView: UIView! {
        didSet {
            sourceView.backgroundColor = .appOrange
        }
    }
    @IBOutlet private weak var detailView: UIView! {
        didSet {
            detailView.backgroundColor = .appGreen
        }
    }
    @IBOutlet private weak var detailLabel: UILabel! {
        didSet {
            detailLabel.textColor = .textColor
        }
    }
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .textColor
        }
    }
    @IBOutlet private weak var summaryLabel: UILabel! {
        didSet {
            summaryLabel.textColor = .textColor
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.roundCorners(.allCorners, radius: 20)
            containerView.backgroundColor = .cardBackgroundColor
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    public func configure(with news: NewsProtocol) {
        newsImageView?.loadImageWithUrl(urlString: news.image)
        sourceLabel.text = news.source
        detailLabel.text = "Detaylar..."
        titleLabel.text = news.name
        summaryLabel.text = news.description
    }
    
}


class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
}
