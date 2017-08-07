//
//  ConectedFriendsTableViewController.swift
//  Retos2
//
//  Created by MobileLab User on 5/6/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class ConectedFriendsTableViewController: UITableViewController {
    
    var items = [UserObject]()
    var newItems = [UserObject]()
    let defaults = NSUserDefaults.standardUserDefaults()
    var urlString: String = ""
    @IBOutlet weak var NavigationView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NavigationView.backgroundColor = Configuration.Colors.white
        tableView.backgroundColor = Configuration.Colors.finalBlack
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl?.tintColor = Configuration.Colors.black
        refreshControl?.backgroundColor = Configuration.Colors.white
    }
    
    func refresh(){
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
        refresh()
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
    
    override func viewWillDisappear(animated: Bool) {
        items = []
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
        let cell = tableView.dequeueReusableCellWithIdentifier("ConectedFriendsIdentifier") as! ConectedFriendsTableViewCell
        let users = self.items[indexPath.row]
        urlString = users.photo
       
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
            
            cell.FriendImage.layer.cornerRadius = cell.FriendImage.frame.size.width/2
            cell.FriendImage.clipsToBounds = true
        }
        
        cell.ConectedStatus.layer.cornerRadius = cell.ConectedStatus.frame.size.width/2
        cell.ConectedStatus.clipsToBounds = true
        cell.lblName.text = users.name
        
        
        if (cell.rowSelected){
            cell.imgCheked.hidden = false
        }
        else {
            cell.imgCheked.hidden = true
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ConectedFriendsTableViewCell
       
        if (cell.rowSelected){
            cell.imgCheked.hidden = true
            cell.rowSelected = false
            
            var index = 0
            for (var x = 0; x < newItems.count; x++) {
                if( newItems[x] === items[indexPath.row] ){
                    index = x;
                    break;
                }
            }
            newItems.removeAtIndex(index)
            print(newItems)
        }
        else {
            cell.imgCheked.hidden = false
            cell.rowSelected = true
            newItems.append(items[indexPath.row])
            print(newItems)
        }
    }
    
    @IBAction func btnDone(sender: AnyObject) {
        if newItems.count == 1{
            let alert = UIAlertController(title: "Necesitas seleccionar a mas de un jugador", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                print("ok")
            })
            alert.addAction(ok)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            FriendsModel.sharedInstance.setArray(newItems)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
