//
//  SplashViewController.swift
//  bonfire
//
//  Created by Allan Martinez on 5/17/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//
import Firebase
import UIKit

class SplashViewController: UIViewController {
    
    let eventRef = Firebase(url: "https://teamwildfire.firebaseio.com/Event")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        eventRef.observeEventType(.Value, withBlock: {snapshot in
            var tempItems = [NSDictionary]()
            for item in snapshot.children {
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            events.eventItems = tempItems
            events.numEvents = tempItems.count
            
            events.eventItems.sortInPlace { (element1, element2) -> Bool in
                return element1["time"]?.description < element2["time"]?.description
            }
            // print(tempItems)
        })
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(
            2.5, target: self, selector: Selector("show"), userInfo: nil, repeats: false
        )
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show() {
        self.performSegueWithIdentifier("showApp", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
