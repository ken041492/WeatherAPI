//
//  ChooseTableViewCell.swift
//  Weather API
//
//  Created by imac-1682 on 2023/8/11.
//

import UIKit

class ChooseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var AreaLabel: UILabel!
    static let identifier = "ChooseTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

