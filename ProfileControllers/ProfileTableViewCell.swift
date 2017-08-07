//
//  ProfileTableViewCell.swift
//  Retos2
//
//  Created by MobileLab User on 5/20/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LabelChallenge: UILabel!
    @IBOutlet weak var UIViewColor: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
