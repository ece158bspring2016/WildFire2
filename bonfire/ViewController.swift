//
//  ViewController.swift
//  bonfire
//
//  Created by Allan Martinez on 5/15/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//
/*
import UIKit

import Firebase

class ViewController: UIViewController {
    
    
    let rootRef = Firebase(url: "https://teamwildfire.firebaseio.com/")
    let event = Firebase(url: "https://teamwildfire.firebaseio.com/Event")
    let user = Firebase(url: "https://teamwildfire.firebaseio.com/User")
    
    //let eventRef = rootRef.childByAppendingPath("Bonfire")
    //let userRef = rootRef.childByAppendingPath("Bonfire")
    //let event = events(name:String?, longitude: Float?, latitude: Float?, time: String?, description: String?, count: Int?

    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBAction func Save(sender: AnyObject) {
        let name = textField?.text
        
        let user1: NSDictionary = ["name": textField.text!, "email": textField2.text!]
        
        let profile = user.ref.childByAppendingPath(name!)
        profile.setValue(user1)
    }
    
    @IBAction func loadDataFromFirebase(sender: UIButton) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        user.observeEventType(.Value, withBlock: {snapshot in
            var tempItems = [NSDictionary]()
            for item in snapshot.children {
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            
            print(tempItems.count)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}*/

