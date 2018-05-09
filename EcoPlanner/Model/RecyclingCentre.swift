//
//  RecyclingCentre.swift
//  EcoPlanner
//
//  Created by user on 03/05/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

class RecyclingCentre: NSObject {
    
    var title: String
    var subtitle: String
    var latitude: Float
    var longitude: Float
    var identifier: Int32
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.latitude = 0
        self.longitude = 0
        self.identifier = 0
    }
    
    init(title: String, subtitle: String, latitude: Float, longitude: Float, identifier: Int32) {
        self.title = title
        self.subtitle = subtitle
        self.latitude = latitude
        self.longitude = longitude
        self.identifier = identifier
    }
    
}
