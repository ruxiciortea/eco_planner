//
//  RecyclingCentre.swift
//  EcoPlanner
//
//  Created by user on 03/05/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import SKMaps

class RecyclingCentre: SKAnnotation {
    
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String, latitude: CLLocationDegrees , longitude: CLLocationDegrees) {
        self.title = title
        self.subtitle = subtitle
        
        super.init()

        self.location.latitude = latitude
        self.location.longitude = longitude
    }
    
}
