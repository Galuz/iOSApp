//
//  CreateGameTableViewController.swift
//  Retos2
//
//  Created by MobileLab User on 5/6/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit

class CreateGameTableViewController: UITableViewController, UIPickerViewDelegate,UIPickerViewDataSource{
    
    var items = [UserObject]()
    @IBOutlet weak var txtCategory: UITextField!
    var picker:UIPickerView!
    var pickerData: [String] = ["Parejas","Extremos","Leves","ParejasExtremas"]
    var CategoryName: String!
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Configuration.Colors.finalBlack
        
        fillFriends()
        //pickerView
        
        let CustomPickerView:UIView = UIView (frame: CGRectMake(0, 100, view.frame.size.width, 160))
        CustomPickerView.backgroundColor = Configuration.Colors.white
        
        picker = UIPickerView(frame: CGRectMake(0, 0, view.frame.size.width, 160))
        picker.delegate = self
        picker.dataSource = self
    
        CustomPickerView .addSubview(picker)
        
        txtCategory.inputView = CustomPickerView
        
        let doneButtonPickerView:UIButton = UIButton (frame: CGRectMake(100, 100, 100, 44))
        doneButtonPickerView.setTitle("Done", forState: UIControlState.Normal)
        doneButtonPickerView.setTitleColor(Configuration.Colors.finalBlack, forState: UIControlState.Normal)
        doneButtonPickerView.addTarget(self, action: "creatingPickerView", forControlEvents: UIControlEvents.TouchUpInside)
        doneButtonPickerView.backgroundColor = Configuration.Colors.white
        doneButtonPickerView.layer.borderWidth = 1.0
        doneButtonPickerView.layer.borderColor = Configuration.Colors.finalBlack.CGColor
        txtCategory.inputAccessoryView = doneButtonPickerView
    }
    override func viewWillAppear(animated: Bool) {
        fillFriends()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        items = []
    }

    func creatingPickerView(){
        txtCategory.text = CategoryName
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Picker view data source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            CategoryName = pickerData[0]
        }
        else if row == 1 {
            CategoryName = pickerData[1]
        }
        else if row == 2 {
            CategoryName = pickerData[2]
        }
        else if row == 3 {
            CategoryName = pickerData[3]
        }
        
        return CategoryName
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if row == 0 {
            CategoryName = pickerData[0]
            txtCategory.text = pickerData[0]
        }
        else if row == 1 {
            CategoryName = pickerData[1]
            txtCategory.text = pickerData[1]
        }
        else if row == 2 {
            CategoryName = pickerData[2]
            txtCategory.text = pickerData[2]
        }
        else if row == 3 {
            CategoryName = pickerData[3]
            txtCategory.text = pickerData[3]
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func fillFriends(){
        items = FriendsModel.sharedInstance.retrieveArray()
        self.tableView.reloadData()
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CreateGameIdentifier") as! CreateGameTableViewCell
        urlString = items[indexPath.row].photo
        if urlString == ""{
            cell.FriendImage.image = UIImage(named: "user_icon")
        }
        else{
            let url = NSURL(string: urlString)
            let data = NSData(contentsOfURL: url!)
            cell.FriendImage.layer.cornerRadius = cell.FriendImage.frame.size.width/2
            cell.FriendImage.clipsToBounds = true
            if(data == nil){
                cell.FriendImage.image = UIImage(named: "user_icon")
            }
            else{
                cell.FriendImage.image = UIImage(data: data!)
            }
        }
        cell.lblName.text = items[indexPath.row].name
        return cell
    }
    
    @IBAction func InviteFriends(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("ModalController")
        self.presentViewController(vc, animated: true, completion: nil)
//        let modalVieww = storyboard!.instantiateViewControllerWithIdentifier("ModalController") as! ConectedFriendsTableViewController
//        self.presentViewController(modalVieww, animated: true, completion: nil)
    }
    @IBAction func ButtonPlayGame(sender: AnyObject) {
        let PlayView = storyboard!.instantiateViewControllerWithIdentifier("GameStartSViewController")
        if (CategoryName == nil){
            let alert = UIAlertController(title: "Selecciona una Categoria", message: "", preferredStyle: UIAlertControllerStyle.Alert)
          
            let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                print("ok")
            })
            alert.addAction(OK)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else{
            SelectedCategoryModel.SharedInstance.setCategory(CategoryName)
        }
        self.presentViewController(PlayView, animated: true, completion: nil)
    }
    
    
}
