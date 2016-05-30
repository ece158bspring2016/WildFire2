//
//  Location.swift
//  bonfire
//
//  Created by Allan Martinez on 5/16/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//

import Foundation


import Foundation
import CoreData

class Location: NSManagedObject {
    
    @NSManaged var timestamp: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var run: NSManagedObject
 
}