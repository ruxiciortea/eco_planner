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
    
    static func getRecyclingCentres() -> [RecyclingCentre] {
        var recyclingCentresArray: [RecyclingCentre] = []
        
        let recyclingCentre1 = RecyclingCentre(title: "Strada Căpitan Grigore Ignat 60-62", subtitle: "Open: 8:00 - 17:00", latitude: 46.793782, longitude: 23.659656, identifier: 1)
        recyclingCentresArray.append(recyclingCentre1)
        
        let recyclingCentre2 = RecyclingCentre(title: "Strada Sobarilor 31", subtitle: "Open: 8:00 - 17:00", latitude: 46.795209, longitude: 23.612519, identifier: 2)
        recyclingCentresArray.append(recyclingCentre2)
        
        let recyclingCentre3 = RecyclingCentre(title: "Strada Salcâmului 5-7", subtitle: "Open: 7:00 - 15:00", latitude: 46.764758, longitude: 23.568555, identifier: 3)
        recyclingCentresArray.append(recyclingCentre3)
        
        let recyclingCentre4 = RecyclingCentre(title: "Bulevardul Muncii 16", subtitle: "Open: 7:30 - 16:00", latitude: 46.793567, longitude: 23.628062, identifier: 4)
        recyclingCentresArray.append(recyclingCentre4)
        
        let recyclingCentre5 = RecyclingCentre(title: "Bulevardul Cetatea Fetei 400", subtitle: "Open: 8:30 - 17:30", latitude: 46.732298, longitude: 23.483459, identifier: 5)
        recyclingCentresArray.append(recyclingCentre5)
        
        return recyclingCentresArray
    }
    
    static func recyclingCentreForIdentifier(identifier: Int32) -> RecyclingCentre? {
        for centre in RecyclingCentre.getRecyclingCentres() {
            if centre.identifier == identifier {
                return centre
            }
        }
        
        return nil
    }
    
}
