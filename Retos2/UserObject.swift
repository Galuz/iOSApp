//
//  UserObject.swift
//  WebService
//
//  Created by MobileLab User on 4/29/16.
//  Copyright © 2016 TCS. All rights reserved.
//

class UserObject {
    
        var name: String!
        var photo: String!
    
    required init(json: JSON) {
        
        name = json["name"].stringValue
        photo = json["photo"].stringValue
    }

}
