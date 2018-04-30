//
//  MapViewController.swift
//  EcoPlanner
//
//  Created by user on 25/04/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import SKMaps

class MapViewController: UIViewController, SKPositionerServiceDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kNavyBlueColor
        
        SKPositionerService.sharedInstance().delegate = self
//        SKPositionerService.sharedInstance().positionerMode
    }
}
