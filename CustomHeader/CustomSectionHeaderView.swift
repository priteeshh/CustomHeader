//
//  CustomSectionHeaderView.swift
//  ExpandCollapsTableView
//
//  Created by Preeteesh Remalli on 19/06/23.
//

import UIKit

class CustomSectionHeaderView: UITableViewHeaderFooterView {
    let customImageView = UIImageView()
    let customLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        // Configure the image view
        customImageView.frame = CGRect(x: 10, y: 10, width: 80, height: 44)
        addSubview(customImageView)

        // Configure the label
        customLabel.frame = CGRect(x: 100, y: 10, width: frame.width - 110, height: 44)
        addSubview(customLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
