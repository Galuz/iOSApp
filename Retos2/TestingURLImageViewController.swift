//
//  TestingURLImageViewController.swift
//  Retos2
//
//  Created by MobileLab User on 5/18/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class TestingURLImageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Configuration.Colors.finalBlack
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ButtonLogin(sender: AnyObject) {
        
        let vc = storyboard!.instantiateViewControllerWithIdentifier("TabBarController")
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
