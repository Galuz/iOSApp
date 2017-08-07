//
//  ChallengesObject.swift
//  Retos2
//
//  Created by MobileLab User on 5/20/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class ChallengesObject: NSObject {
    var name: String!
    
    required init(json: JSON) {
        name = json["challenges_name"].stringValue
    }
}
