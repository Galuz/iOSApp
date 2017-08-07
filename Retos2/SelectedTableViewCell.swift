//
//  SelectedTableViewCell.swift
//  Retos2
//
//  Created by MobileLab User on 5/24/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class SelectedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelSelected: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
