//
//  FriendsTableViewController.swift
//  Retos2
//
//  Created by MobileLab User on 5/2/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    var items = [UserObject]()
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Configuration.Colors.finalBlack
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl?.tintColor = Configuration.Colors.black
        refreshControl?.backgroundColor = Configuration.Colors.white
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
    
    func refresh() {
        self.items = []
        RestApiManager.sharedInstance.getRandomUser { (json: JSON) in
            if let results = json.array {
                print(results[0])
                
                for entry in results {
                    self.items.append(UserObject(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                    SwiftLoader.hide()
                    self.refreshControl?.endRefreshing()
                })
                
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        actionShowLoader()
        self.refresh()
    }
    override func viewWillDisappear(animated: Bool) {
        self.items = []
        
        super.viewWillDisappear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendsIdentifier") as! FriendsTableViewCell
        let user = self.items[indexPath.row]
        urlString = user.photo
        
        if urlString == ""{
            cell.FriendImage.image = UIImage(named: "user_icon")
        }
        else{
            
            let url = NSURL(string: urlString)
            let data = NSData(contentsOfURL: url!)
            
            if (data == nil){
                cell.FriendImage.image = UIImage(named: "user_icon")
            }
            else{
                cell.FriendImage.image = UIImage(data: data!)
            }
            
        }
        cell.FacebookIcon.layer.cornerRadius = cell.FacebookIcon.frame.size.width/2
        cell.FacebookIcon.clipsToBounds = true
        cell.FriendImage.layer.cornerRadius = cell.FriendImage.frame.size.width/2
        cell.FriendImage.clipsToBounds = true
        cell.FriendNamelbl.text = user.name
        return cell
    }
    
}
