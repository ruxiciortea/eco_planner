//
//  MapViewController.swift
//  EcoPlanner
//
//  Created by user on 25/04/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import SKMaps

class MapViewController: UIViewController, SKMapViewDelegate {

    @IBOutlet weak var mapView: SKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kNavyBlueColor

        self.mapView.delegate = self
        
        SKPositionerService.sharedInstance().startLocationUpdate()
        
        self.mapView.centerOnCurrentPosition()
        self.mapView.animate(toZoomLevel: 16)
    }

    func mapView(_ mapView: SKMapView, didRotateWithAngle angle: Float) {
        self.mapView.settings.showCompass = true
    }

    func mapViewDidSelectCompass(_ mapView: SKMapView) {
        self.mapView.animate(toBearing: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.mapView.settings.showCompass = false
        }
    }
}


//        let view = UIView()
//        view.frame = CGRect(x: 100, y: 300, width: 300, height: 300)
//        view.backgroundColor = .red
//        self.view.addSubview(view)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) {
//            UIView.animate(withDuration: 3, animations: {
//                view.backgroundColor = .green
//            }, completion: { (bool) in
//                UIView.animate(withDuration: 3, animations: {
//                    view.frame = CGRect(x: 100, y: 500, width: 200, height: 400)
//                }, completion: { (bool) in
//                    view.frame = CGRect(x: 100, y: 300, width: 300, height: 300)
//                })
//            })
//        }
//
//        var sum = 0
//
//        DispatchQueue.main.sync {
////            for index in 0...10000000 {
////                print(sqrt(index))
////                sum = sum + sqrt(index)
////            }
//        }
//
//        DispatchQueue.global(qos: .background).async {
////            for index in 0...10000000 {
////                print(sqrt(index))
////                sum = sum + sqrt(index)
////            }
//            DispatchQueue.main.async(execute: {
//                // update ui
//                print(sum)
//            })
//        }
//
//        print(sum)
//
//        sum = 0
//
//        DispatchQueue.main.async {
////            for index in 0..10000000 {
////                print(sqrt(index))
////                sum = sum + sqrt(index)
////            }
//        }
//
//        print(sum)
//
//        UIView.animate(withDuration: 10) {
//            view.backgroundColor = .blue
//            view.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
//        }
