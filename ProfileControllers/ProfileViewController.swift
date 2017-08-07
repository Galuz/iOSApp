//
//  ProfileViewController.swift
//  Retos2
//
//  Created by MobileLab User on 6/1/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var items = [UserObject]()
    var urlString: String = ""
    let StringValues = ["Retos Completados","Retos No completados"]
  
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var LabelProfileName: UILabel!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Configuration.Colors.finalBlack
    }
    
    func actionShowLoader() {
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 170
        config.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1)
        config.spinnerColor = UIColor(red:255, green:255, blue:255, alpha:1)
        config.titleTextColor = UIColor(red:255, green:255, blue:255, alpha:1)
        config.spinnerLineWidth = 2.0
        config.foregroundColor = UIColor.blackColor()
        config.foregroundAlpha = 0.5
        SwiftLoader.setConfig(config)
        SwiftLoader.show(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        actionShowLoader()
        refresh()
    }
    
    func refresh() {
        self.items = []
        RestApiManager.sharedInstance.getRandomUser { (json: JSON) in
            if let results = json.array {
                print(results[0])
                
                for entry in results {
                    self.items.append(UserObject(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    let user = self.items[0]
                    self.urlString = user.photo
                    let url = NSURL(string: self.urlString)
                    let data = NSData(contentsOfURL: url!)
                    self.ProfileImage.image = UIImage(data: data!)
                    self.ProfileImage.layer.cornerRadius = self.ProfileImage.frame.size.width/2
                    self.ProfileImage.clipsToBounds = true
                    self.LabelProfileName.text = user.name
                    SwiftLoader.hide()
                    self.refreshControl?.endRefreshing()
                })
                
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.items = []
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonLogout(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
