//
//  EventInfoTableViewController.swift
//  bonfire
//
//  Created by Allan Martinez on 5/16/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//

import UIKit
import MapKit

class EventInfoTableViewController: UITableViewController {
    
    var toPass: NSDictionary?
    var infoArray = [AnyObject]()
    
    @IBOutlet weak var timeView: UITextView!
    @IBOutlet weak var locView: UITextView!
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var countView: UILabel!
    @IBOutlet weak var hostView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.toPass!["name"]?.description
        for (_,val) in toPass! {
            infoArray.append(val)
        }
        
        // Display Time/Description
        timeView.text = toPass!["time"]?.description
        descView.text = toPass!["description"]?.description
        countView.text = toPass!["Attendees"]?.count.description
        hostView.text = toPass!["host"]?.description
        
        // Convert longitude/latitude to address
        var loc = toPass!["location"] as! [CLLocationDegrees]
        
        let long = loc[1] 
        let lat = loc[0]
        
        let location = CLLocation(latitude: long, longitude: lat)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks?.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                let addressinfo = (pm.addressDictionary?["FormattedAddressLines"])! as! [String]
                var address = addressinfo[0]
                
                for var i = 1; i < addressinfo.count; i++ {
                    address = address + "\n" + addressinfo[i]
                }
                
                self.locView.text = address
            }
            else {
                print("Problem with the data received from geocoder")
            }
            
           
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
