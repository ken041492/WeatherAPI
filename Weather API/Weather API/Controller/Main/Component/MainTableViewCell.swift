//
//  MainTableViewCell.swift
//  Weather API
//
//  Created by imac-1682 on 2023/8/11.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var Area: UILabel!
    @IBOutlet weak var Wx: UILabel!
    @IBOutlet weak var MaxT: UILabel!
    @IBOutlet weak var MinT: UILabel!
    @IBOutlet weak var CI: UILabel!
    @IBOutlet weak var PoP: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    static let identifier = "MainTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
