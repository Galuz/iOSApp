//
//  ProfileTableViewController.swift
//  Retos2
//
//  Created by MobileLab User on 5/20/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    var items = [UserObject]()
    var urlString: String = ""
    let StringValues = ["Retos Completados","Retos No completados"]
    @IBOutlet weak var LabelProfileName: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
   
    internal static var pastView: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        ProfileRestApiManager.sharedInstance.getRandomUser { (json: JSON) in
            if let results = json.array {
                print(results[0])
                
                for entry in results {
                    self.items.append(UserObject(json: entry))
                }
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                    let user = self.items[0]
                    self.urlString = user.photo
                    let url = NSURL(string: self.urlString)
                    let data = NSData(contentsOfURL: url!)
                    self.ProfileImage.image = UIImage(data: data!)
                    self.ProfileImage.layer.cornerRadius = self.ProfileImage.frame.size.width/2
                    self.ProfileImage.clipsToBounds = true
                    self.LabelProfileName.text = user.name
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return StringValues.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChallengeStatusIdentifier") as! ProfileTableViewCell
        cell.LabelChallenge.text = StringValues[indexPath.row]
        cell.UIViewColor.layer.cornerRadius = cell.UIViewColor.frame.size.width/2
        cell.UIViewColor.clipsToBounds = true
        return cell
    }
    
    @IBAction func ButtonLogout(sender: AnyObject) {
       self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
