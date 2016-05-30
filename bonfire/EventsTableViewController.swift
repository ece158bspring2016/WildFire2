//
//  EventsTableViewController.swift
//  bonfire
//
//  Created by Allan Martinez on 5/16/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//

import UIKit
import Firebase

class EventsTableViewController: UITableViewController {

    let eventRef = Firebase(url: "https://teamwildfire.firebaseio.com/Event")
    
    // Reload tableview with firebase events
    @IBAction func refreshbutton(sender: AnyObject) {
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
        tableView.reloadData()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
       /* UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        eventRef.observeEventType(.Value, withBlock: {snapshot in
            var tempItems = [NSDictionary]()
            for item in snapshot.children {
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            events.eventItems = tempItems
            events.numEvents = tempItems.count
            print(events.numEvents)
        })*/
        
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.numEvents
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath)

        // Configure the cell...
        let event = events.eventItems[indexPath.row]
        cell.textLabel?.text = event["name"]?.description
        cell.detailTextLabel?.text = event["time"]?.description
        return cell
    }
    
    @IBAction func cancelToEventViewController(segue:UIStoryboardSegue) {
        if segue.identifier == "cancel" {
            tableView.reloadData()
        }
    }
    
    @IBAction func saveEventDetail(segue:UIStoryboardSegue) {
        if segue.identifier == "saveEvent" {
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.'
        var selectedEvent: NSDictionary?
        if (segue.identifier == "chooseEvent") {
            
            // Pass event information to EventInfoTableViewController
            var svc = segue.destinationViewController as! EventInfoTableViewController
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    selectedEvent = events.eventItems[index]
                }
    
            svc.toPass = selectedEvent
            
        }
    }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
 

}
