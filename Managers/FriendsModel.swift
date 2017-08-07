//
//  FriendsModel.swift
//  Retos2
//
//  Created by MobileLab User on 5/25/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class FriendsModel: NSObject {
    
    private var newItems = [UserObject]()

    static let sharedInstance = FriendsModel()
    
    func setArray(newItems:[UserObject]){
        self.newItems = newItems
    }
    func retrieveArray() -> [UserObject]{
        return self.newItems
    }
    func DestroyObject(){
        newItems = []
    }
}
