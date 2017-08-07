//
//  UserCoreDataManager.swift
//  Retos2
//
//  Created by MobileLab User on 4/28/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit
import CoreData

class UserCoreDataManager: NSObject {
    
    //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    struct Static {
        static var instance:UserCoreDataManager? = nil
        static var token:dispatch_once_t = 0
    }
    
    class func sharedInstance() -> UserCoreDataManager! {
        dispatch_once(&Static.token) {
            Static.instance = self.init()
        }
        return Static.instance!
    }
    
    required override init() {
        assert(Static.instance == nil, "Singleton already initialized!")
    }
    
    func savePersonWithName(name: String, pass: String) -> NSManagedObject?{
        let entity =  NSEntityDescription.entityForName("Users", inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "name")
        person.setValue(pass, forKey: "pass")
        
        do  {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return nil
        }
        return person
    }
    
    func retrievePersons() -> [NSManagedObject]?{
        let fetchRequest = NSFetchRequest(entityName: "Users")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            return results
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return nil
        }
    }

}
