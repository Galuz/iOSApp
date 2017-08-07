//
//  RegisterViewController.swift
//  Retos2
//
//  Created by MobileLab User on 5/4/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet var txtUser: UITextField!
    @IBOutlet var txtContra: UITextField!
    
    var people: [NSManagedObject] = []
    let coreManager = UserCoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        people = coreManager.retrievePersons()!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRegistrar(sender: AnyObject) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("ViewController")
        let person = coreManager.savePersonWithName(txtUser.text!, pass: txtContra.text!)
        if(person != nil){
            people.append(person!)
            self.presentViewController(vc, animated: true, completion: nil)
        }
        else{
            print("NO Guardo")
        }
    }

}
