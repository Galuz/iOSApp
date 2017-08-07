//
//  GameStartSViewController.swift
//  Retos2
//
//  Created by MobileLab User on 6/2/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class GameStartSViewController: UIViewController {
    
    var items = [UserObject]()
    var challenges = [ChallengesObject]()
    var categoryName: String!
    var countDown = 25,
        friendsCounter = 0,
        round = 0
    var flag: Bool = true
    var urlString: String = ""
    var indexPath: Int = 0
    var url: NSURL = NSURL()
    var data: NSData = NSData()
    var url2: NSURL = NSURL()
    var data2: NSData = NSData()
    var url3: NSURL = NSURL()
    var data3: NSData = NSData()
    var pictureCounter = -1
    var pictureCounter2 = 0
    var pictureCounter3 = 1
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var centerImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var challengeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexPath = items.count
        print(pictureCounter)
    }
    
    
    override func viewDidAppear(animated: Bool) {
       fristScreen()
    }
    
    override func viewWillAppear(animated: Bool) {
        fillFriends()
        categoryName = SelectedCategoryModel.SharedInstance.retrieveCategory()
        categoryLabel.text = categoryName
        ChallengesRestApiManager.sharedInstance.getRandomUser{(json: JSON) in
            if let results = json.array{
                print(results[0])
                
                for entry in results{
                    self.challenges.append(ChallengesObject(json: entry))
                }
                dispatch_async(dispatch_get_main_queue(), {
                   // let length = self.challenges.count
                    //let random = Int(arc4random_uniform(UInt32(length)))
                    let user = self.challenges[6]
                    print(user.name)
                    self.challengeLabel.text = user.name
                })
            }
        }
        
    }
    
    func timer(){
        if (flag == true){
            
            if(countDown > 0) {
                countDownLabel.text = String(countDown--)
            }
            else{
                flag = false
                print("error")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillFriends(){
        items = FriendsModel.sharedInstance.retrieveArray()
    }
    func goto(){
        
        if data == "" {
            leftImage.image = UIImage(named: "user_icon")
        }
        else{
            leftImage.image = UIImage(data: data)
            
        }
    }
    
    func fristScreen(){
        
        if pictureCounter < items.count{
            url = NSURL(string: items[items.count-1].photo)!
            data = NSData(contentsOfURL: url)!
            leftImage.image = UIImage(data: data)
        }
        else{
            url = NSURL(string: items[pictureCounter].photo)!
            data = NSData(contentsOfURL: url)!
        }
        url2 = NSURL(string: items[pictureCounter2].photo)!
        data2 = NSData(contentsOfURL: url2)!
        url3 = NSURL(string: items[pictureCounter3].photo)!
        data3 = NSData(contentsOfURL: url3)!
        
        if data2 == "" {
            centerImage.image = UIImage(named: "user_icon")
        }
            
        else{
            centerImage.image = UIImage(data: data2)
        }
        
        if data3 == ""{
            rightImage.image = UIImage(named: "user_icon")
        }
        else{
            rightImage.image = UIImage(data: data3)
        }
        
        leftImage.layer.cornerRadius = leftImage.frame.size.width/2
        leftImage.clipsToBounds = true
        centerImage.layer.cornerRadius = centerImage.frame.size.width/2
        centerImage.clipsToBounds = true
        rightImage.layer.cornerRadius = rightImage.frame.size.width/2
        rightImage.clipsToBounds = true
        
        pictureCounter++
        pictureCounter2++
        pictureCounter3++
    }
    
    @IBAction func likeButton(sender: AnyObject) {
     
        if pictureCounter == -1{
            url = NSURL(string: items[items.count-1].photo)!
            data = NSData(contentsOfURL: url)!
            leftImage.image = UIImage(data: data)
        }
        else{
            url = NSURL(string: items[pictureCounter].photo)!
            data = NSData(contentsOfURL: url)!
            goto()
        }
        if pictureCounter2 == items.count{
            
            let alert = UIAlertController(title: "La ronda ha terminado, desea continuar?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            let si = UIAlertAction(title: "SI", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                //self.AlertOptions = "OK"
                self.pictureCounter = -1
                self.pictureCounter2 = 0
                self.pictureCounter3 = 1
                self.fristScreen()
            })
            let no = UIAlertAction(title: "NO", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                print("NO")
            })
            alert.addAction(si)
            alert.addAction(no)
            self.presentViewController(alert, animated: true, completion: nil)

        }
        else{
            url2 = NSURL(string: items[pictureCounter2].photo)!
            data2 = NSData(contentsOfURL: url2)!
        }
        if pictureCounter3 > items.count{
            print("bla")
        }
        else{
            if pictureCounter3 == items.count{
                let url = NSURL(string: items[0].photo)!
                let data = NSData(contentsOfURL: url)!
                rightImage.image = UIImage(data: data)
            }
            else{
                url3 = NSURL(string: items[pictureCounter3].photo)!
                data3 = NSData(contentsOfURL: url3)!
            }
        }
        
        goto()
        
        if data2 == "" {
            centerImage.image = UIImage(named: "user_icon")
        }
            
        else{
            centerImage.image = UIImage(data: data2)
        }
        
        if pictureCounter3 == items.count{
            let url = NSURL(string: items[0].photo)!
            let data = NSData(contentsOfURL: url)!
            rightImage.image = UIImage(data: data)
        }
        else{
            rightImage.image = UIImage(data: data3)
        }
        
        leftImage.layer.cornerRadius = leftImage.frame.size.width/2
        leftImage.clipsToBounds = true
        centerImage.layer.cornerRadius = centerImage.frame.size.width/2
        centerImage.clipsToBounds = true
        rightImage.layer.cornerRadius = rightImage.frame.size.width/2
        rightImage.clipsToBounds = true
        
        pictureCounter++
        pictureCounter2++
        pictureCounter3++
    }
    
    @IBAction func dislikeButton(sender: AnyObject) {
    }
    
    @IBAction func playButton(sender: AnyObject) {
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timer"), userInfo: nil, repeats: true)
        countDown = 25
    }
    @IBAction func exitButton(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! TabBarController
        vc.nextController = "Padre";
        FriendsModel.sharedInstance.DestroyObject()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

}
