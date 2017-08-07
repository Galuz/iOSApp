//
//  GameStartViewController.swift
//  Retos2
//
//  Created by MobileLab User on 5/18/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class GameStartViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var items = [UserObject]()
    var chellenges = [ChallengesObject]()
    var urlString: String = ""
    var CategoryName: String!
    @IBOutlet weak var LabelCategorySelected: UILabel!
    let instance = ProfileTableViewController()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var LabelTimer: UILabel!
    var count = 25
    var counter = 0
    var round = 0
    var rowToSelect:NSIndexPath!
    var flag: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self;
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        rowToSelect = NSIndexPath (forItem: 0, inSection: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        let rowToSelect: NSIndexPath = NSIndexPath(forRow: counter, inSection: 0)
        let cell = collectionView.cellForItemAtIndexPath(rowToSelect) as! GameStartCollectionViewCell
        cell.ImageFriendsInvited.frame.size.width = 66
        cell.ImageFriendsInvited.frame.size.height = 66
    }
    
    override func viewWillAppear(animated: Bool) {
        fillFriends()
        CategoryName = SelectedCategoryModel.SharedInstance.retrieveCategory()
        LabelCategorySelected.text = CategoryName
        ChallengesRestApiManager.sharedInstance.getRandomUser{(json: JSON) in
            if let results = json.array{
                print(results[0])
                
                for entry in results{
                    self.chellenges.append(ChallengesObject(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(), {
                    let user = self.chellenges[0]
                    print(user.name)
                })
            }
        }
    }
    
    func update() {
        if (flag == true){
            
            if(count > 0) {
                LabelTimer.text = String(count--)
            }
            else{
                
                if (counter == items.count-1) {
                    rowToSelect = NSIndexPath(forRow: 0, inSection: 0)
                }else{
                    rowToSelect = NSIndexPath(forRow: counter+1, inSection: 0)
                }
                
                if (counter == items.count-1){
                    counter = 0
                    round = 1
                }else{
                    counter++
                }
                
                count = 25
                collectionView.reloadData()
                collectionView.reloadItemsAtIndexPaths([rowToSelect])
                //collectionView.reloadItemsAtIndexPaths([NSIndexPath(forRow: rowToSelect.row, inSection: 0)])
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillFriends(){
        items = FriendsModel.sharedInstance.retrieveArray()
        self.collectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StartGameIdentifier",forIndexPath: indexPath) as! GameStartCollectionViewCell
        urlString = items[indexPath.row].photo
       
        if urlString == ""{
            cell.ImageFriendsInvited.image = UIImage(named: "user_icon")
        }
        else{
            let url = NSURL(string: urlString)
            let data = NSData(contentsOfURL: url!)
            if(cell.ImageFriendsInvited.frame.size.width == 66){
                cell.ImageFriendsInvited.layer.cornerRadius = 33
                cell.ImageFriendsInvited.clipsToBounds = true
            }
            else{
                cell.ImageFriendsInvited.layer.cornerRadius = cell.ImageFriendsInvited.frame.size.width/2
                cell.ImageFriendsInvited.clipsToBounds = true
            }
            if(data == nil){
                cell.ImageFriendsInvited.image = UIImage(named: "user_icon")
            }
            else{
                cell.ImageFriendsInvited.image = UIImage(data: data!)
            }
        }
        cell.LabelFriendsInvited.text = items[indexPath.row].name
        if rowToSelect == indexPath{
            cell.ImageFriendsInvited.frame.size.width = 66
            cell.ImageFriendsInvited.frame.size.height = 66
        }
        else{
            cell.ImageFriendsInvited.frame.size.width = 46
            cell.ImageFriendsInvited.frame.size.height = 46
        }
        
        return cell
    }
     func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    @IBAction func ButtonExit(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! TabBarController
        vc.nextController = "Padre";
        FriendsModel.sharedInstance.DestroyObject()
        self.presentViewController(vc, animated: true, completion: nil)        
    }

    @IBAction func LikeButton(sender: AnyObject) {
        let alert = UIAlertController(title: "Deseas compartir en facebook?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            //self.AlertOptions = "OK"
            self.count = 25
            self.flag = true
        })
        alert.addAction(OK)
        self.presentViewController(alert, animated: true, completion: nil)
        
        //let rowToSelect2:NSIndexPath;
        if (counter == items.count-1) {
            rowToSelect = NSIndexPath(forRow: 0, inSection: 0)
           // rowToSelect2 = NSIndexPath(forRow: counter, inSection: 0)
        }else{
          //  rowToSelect2 = NSIndexPath(forRow: counter, inSection: 0)
            rowToSelect = NSIndexPath(forRow: counter+1, inSection: 0)
        }
        
        if (counter == items.count-1){
            counter = 0
            round = 1
        }else{
            counter++
        }
        count = 25
        collectionView.reloadData()
        collectionView.reloadItemsAtIndexPaths([rowToSelect])
        flag = false
    }

    @IBAction func DisLikeButton(sender: AnyObject) {
    }
    
}
