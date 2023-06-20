//
//  CustomSectionHeaderView.swift
//  ExpandCollapsTableView
//
//  Created by Preeteesh Remalli on 19/06/23.
//

import UIKit

class CustomSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionTitle: UILabel!
    
    @IBOutlet weak var attachBtn: UIImageView!
    
    @IBOutlet weak var dropDownBtn: UIImageView!
    static let reuseIdentifier: String = String(describing: self)
    static var nib: UINib {
            return UINib(nibName: String(describing: self), bundle: nil)
        }
}
