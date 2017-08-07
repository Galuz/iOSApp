//
//  ViewController.swift
//  Retos2
//
//  Created by MobileLab User on 4/27/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet var txtUser: UITextField!
    @IBOutlet var txtPass: UITextField!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogin(sender: AnyObject) {
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Users")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController")
    
        request.predicate = NSPredicate(format: "name == %@ and pass == %@ ", txtUser.text!, txtPass.text!)
        do{
            let results = try context.executeFetchRequest(request) as? [NSManagedObject]
            
            if(results?.count > 0){
                defaults.setObject(txtUser.text, forKey: "name")
                self.presentViewController(vc, animated: true, completion: nil)
                
            }
            else{
                print("no se pudo")
            }
        }
        catch{
            print("no se pudo")
        }
    }

}

