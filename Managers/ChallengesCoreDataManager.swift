//
//  ChallengesCoreDataManager.swift
//  Retos2
//
//  Created by MobileLab User on 4/28/16.
//  Copyright © 2016 TCS. All rights reserved.
//

import UIKit
import CoreData

class ChallengesCoreDataManager: NSObject {
    
    //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    struct Static {
        static var instance:ChallengesCoreDataManager? = nil
        static var token:dispatch_once_t = 0
    }
    
    class func sharedInstance() -> ChallengesCoreDataManager! {
        dispatch_once(&Static.token) {
            Static.instance = self.init()
        }
        return Static.instance!
    }
    
    required override init() {
        assert(Static.instance == nil, "Singleton already initialized!")
    }
    
    func savePersonWithName(name: String) -> NSManagedObject?{
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext:managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "name")
        
        do  {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        return person
    }
    
    func retrievePersons() -> [NSManagedObject]?{
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            return results
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return nil
        }
    }

}
