//
//  LocationViewController.swift
//  
//
//  Created by Allan Martinez on 5/31/16.
//
//

import UIKit

class LocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelChooseLoc(segue:UIStoryboardSegue) {
        if segue.identifier == "cancelLoc" {
            print("HI")
        }
    }
    
    @IBAction func saveLoc(segue:UIStoryboardSegue) {
        if segue.identifier == "save" {
        }
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
