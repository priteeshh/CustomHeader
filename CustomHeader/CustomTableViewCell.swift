//
//  CustomTableViewCell.swift
//  CustomHeader
//
//  Created by Preeteesh Remalli on 19/06/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var rowTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
