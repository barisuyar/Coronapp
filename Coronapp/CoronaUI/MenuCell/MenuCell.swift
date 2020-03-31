//
//  MenuCell.swift
//  CoronaUI
//
//  Created by Barış Uyar on 30.03.2020.
//  Copyright © 2020 Barış Uyar. All rights reserved.
//

import UIKit

public protocol MenuItemProtocol {
    var title: String { get }
}

public class MenuCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: MenuItemProtocol) {
        titleLabel.text = model.title
    }
}
