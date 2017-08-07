//
//  FriendsTableViewCell.swift
//  Retos2
//
//  Created by MobileLab User on 5/2/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet var FriendNamelbl: UILabel!
    @IBOutlet weak var FriendImage: UIImageView!

    @IBOutlet weak var FacebookIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
