//
//  UserDefaults.swift
//  Retos2
//
//  Created by MobileLab User on 5/17/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class UserDefaults: NSObject {
    
    private var name: String?
   
    struct Static {
        static var instance:UserDefaults? = nil
        static var token:dispatch_once_t = 0
    }
    
    class func sharedInstance() -> UserDefaults! {
        dispatch_once(&Static.token) {
            Static.instance = self.init()
        }
        return Static.instance!
    }
    
    required override init() {
        
    }
    
    
    func setName(name:String){
        self.name = name
    }
    
    
    func retrieveName() -> String{
        return self.name!
    }

}
