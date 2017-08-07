//
//  ColorExtension.swift
//  Retos2
//
//  Created by MobileLab User on 6/3/16.
//  Copyright © 2016 TCS. All rights reserved.
//
import UIKit

extension UIImage {
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

extension UIView {
    func addProfileBackground() {
//        var items = [UserObject]()
//        var urlString: String = ""
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "bar")
//        
//        ProfileRestApiManager.sharedInstance.getRandomUser { (json: JSON) in
//            if let results = json.array {
//                print(results[0])
//                
//                for entry in results {
//                    //self.items.append(UserObject(json: entry))
//                    items.append(UserObject(json: entry))
//                }
//                
//                dispatch_async(dispatch_get_main_queue(),{
//                    //self.TableView.reloadData()
//                    let user = items[0]
//                    urlString = user.photo
//                    let url = NSURL(string: urlString)
//                    let data = NSData(contentsOfURL: url!)
//                    imageViewBackground.image = UIImage(data: data!)
//                })
//            }
//        }
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleToFill
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }}

