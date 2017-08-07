//
//  TabBarController.swift
//  Retos2
//
//  Created by MobileLab User on 5/10/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    internal var nextController:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(nextController == "Padre"){
            self.selectedIndex = 2
        }
        else{
            print("no es la vista padre")
        }
        UITabBar.appearance().barTintColor = Configuration.Colors.white
        
        UITabBar.appearance().tintColor = Configuration.Colors.purple
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
