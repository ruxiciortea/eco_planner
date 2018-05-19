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
    var latitude: Float
    var longitude: Float
    var identifier: Int32
    
    override init() {
        self.title = ""
        self.latitude = 0
        self.longitude = 0
        self.identifier = 0
    }
    
    init(title: String, latitude: Float, longitude: Float, identifier: Int32) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.identifier = identifier
    }
    
    static func getRecyclingCentres() -> [RecyclingCentre] {
        var recyclingCentresArray: [RecyclingCentre] = []
        
        let recyclingCentre1 = RecyclingCentre(title: "Street", latitude: 46.770930, longitude: 23.598920, identifier: 1)
        recyclingCentresArray.append(recyclingCentre1)
        let recyclingCentre2 = RecyclingCentre(title: "Street", latitude: 46.760430, longitude: 23.578720, identifier: 2)
        recyclingCentresArray.append(recyclingCentre2)
        let recyclingCentre3 = RecyclingCentre(title: "Street", latitude: 46.750930, longitude: 23.548760, identifier: 3)
        recyclingCentresArray.append(recyclingCentre3)
        let recyclingCentre4 = RecyclingCentre(title: "Street", latitude: 46.758930, longitude: 23.568870, identifier: 4)
        recyclingCentresArray.append(recyclingCentre4)
        let recyclingCentre5 = RecyclingCentre(title: "Street", latitude: 46.778930, longitude: 23.585920, identifier: 5)
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
