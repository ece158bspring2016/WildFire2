//
//  globalVars.swift
//  bonfire
//
//  Created by Allan Martinez on 5/16/16.
//  Copyright © 2016 Allan Martinez. All rights reserved.
//
//

import Foundation

struct userInfo {
    static var name = ""
    static var email = ""
    static var host = ""
}
struct userLocation {
    static var latitude = 0.0
    static var longitude = 0.0
}
struct events {
    static var numEvents = 0
    static var eventItems = [NSDictionary]()
}
struct myEvents {
    static var myEventItems = [NSDictionary]()
}