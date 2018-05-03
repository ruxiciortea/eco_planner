//
//  MapViewController.swift
//  EcoPlanner
//
//  Created by user on 25/04/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import SKMaps

class MapViewController: UIViewController, SKMapViewDelegate, CLLocationManagerDelegate, SKCalloutViewDelegate {

    @IBOutlet weak var mapView: SKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kNavyBlueColor

        self.mapView.delegate = self
        
        SKPositionerService.sharedInstance().startLocationUpdate()
        
        for annotation in self.getAnnotaions() {
            self.mapView.addAnnotation(annotation, with: .init())
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.mapView.centerOnCurrentPosition()

        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                self.mapView.animate(toZoomLevel: 12)
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    // MARK: - MapView
  
    func mapView(_ mapView: SKMapView, didRotateWithAngle angle: Float) {
        self.mapView.settings.showCompass = true
    }

    func mapViewDidSelectCompass(_ mapView: SKMapView) {
        self.mapView.animate(toBearing: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.mapView.bearing == 0 {
                self.mapView.settings.showCompass = false
            }
        }
    }
    
    func mapView(_ mapView: SKMapView, didSelect annotation: SKAnnotation) {
        self.mapView.showCallout(for: annotation, withOffset: annotation.offset, animated: true)
    }
    
    // MARK: - Functions

    func getAnnotaions() -> [RecyclingCentre] {
        var annotationArray: [RecyclingCentre] = []
        
        let annotation1 = RecyclingCentre(title: "Street", subtitle: "", latitude: 46.770930, longitude: 23.598920)
        annotation1.offset.y = 43
        annotationArray.append(annotation1)
        
        let annotation2 = RecyclingCentre(title: "Street", subtitle: "", latitude: 46.770930, longitude: 23.598920)
        annotation2.offset.y = 43
        annotationArray.append(annotation2)
        
        let annotation3 = RecyclingCentre(title: "Street", subtitle: "", latitude: 46.770930, longitude: 23.598920)
        annotation3.offset.y = 43
        annotationArray.append(annotation3)
        
        let annotation4 = RecyclingCentre(title: "Street", subtitle: "", latitude: 46.770930, longitude: 23.598920)
        annotation4.offset.y = 43
        annotationArray.append(annotation4)

        let annotation5 = RecyclingCentre(title: "Street", subtitle: "", latitude: 46.770930, longitude: 23.598920)
        annotation5.offset.y = 43
        annotationArray.append(annotation5)
        
        return annotationArray
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
