//
//  EventDetailsTableViewController.swift
//  bonfire
//
//  Created by Allan Martinez on 5/16/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//
//
import Firebase
import UIKit
import MapKit
import CoreLocation
import HealthKit

class EventDetailsTableViewController: UITableViewController, CLLocationManagerDelegate{

    let eventRef = Firebase(url: "https://teamwildfire.firebaseio.com/Event")
    
    let locationManager = CLLocationManager()
    
    var dateFormatter = NSDateFormatter()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    

    @IBOutlet weak var hostField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var timeField: UIDatePicker!
    
    @IBAction func getLocation(sender: AnyObject) {
        let location = self.locationManager.location
        
        if location == nil {
            self.latitude = 0.0
            self.longitude = 0.0
        }
        else {
            latitude = location!.coordinate.latitude
            longitude = location!.coordinate.longitude
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            
            //   latitude = (location?.coordinate.latitude)
            // longitude = (location?.coordinate.longitude)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Save name/time to firebase
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "saveEvent" {
            
            let name = nameField?.text
            print(name)
            
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            
            let newEvent: NSDictionary = ["host": (self.hostField.text)!,"name": (self.nameField.text)!, "description": (self.descriptionField.text)!,
                "time": dateFormatter.stringFromDate(timeField.date), "location": [longitude, latitude]]
            
            if name == "" {
                print("too")
            }
            else {
                print("good")
                let profile = eventRef.ref.childByAppendingPath(name!)
                profile.setValue(newEvent)
                myEvents.myEventItems.append(newEvent)
            }
        }
    }
    
    
    @IBAction func cancelToEventDetails(segue:UIStoryboardSegue) {
        if segue.identifier == "back" {
        }
    }
    
    @IBAction func saveToEventDetails(segue:UIStoryboardSegue) {
        if segue.identifier == "save" {
        }
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
