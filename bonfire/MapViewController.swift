//
//  MapViewController.swift
//  bonfire
//
//  Created by Allan Martinez on 5/31/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
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
        }
        
        let location = self.locationManager.location
        
        if location != nil {
            centerMapOnLocation(location!)
        }
        
        for event in events.eventItems {
            let newAnotation = MKPointAnnotation()
            var locarray = event["location"] as! [Double]
            newAnotation.coordinate = CLLocationCoordinate2DMake(locarray[1],locarray[0])
            newAnotation.title = event["name"]!.description
            newAnotation.subtitle = event["time"]!.description
            mapView.addAnnotation(newAnotation)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
