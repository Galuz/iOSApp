//
//  ConectedFriendsTableViewCell.swift
//  Retos2
//
//  Created by MobileLab User on 5/6/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class ConectedFriendsTableViewCell: UITableViewCell {
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var imgCheked: UIImageView!
    @IBOutlet weak var ConectedStatus: UIView!
    @IBOutlet weak var FriendImage: UIImageView!
    
    var rowSelected = false
    var txtlbl: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
