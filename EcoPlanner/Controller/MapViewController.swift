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
        let coordinate = SKPositionerService.sharedInstance().currentCoordinate
        let region = SKCoordinateRegion(center: coordinate, zoomLevel: 14)
        
        self.mapView.visibleRegion = region
        
        for annotation in self.getAnnotaions() {
            self.mapView.addAnnotation(annotation, with: .init())
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
        self.mapView.hideCallout()
        self.mapView.showCallout(for: annotation, withOffset: annotation.offset, animated: true)
    }
    
    func mapView(_ mapView: SKMapView, calloutViewFor annotation: SKAnnotation) -> UIView? {
        let calloutView = SKCalloutView()
        
        calloutView.titleLabel.text = ""
        calloutView.subtitleLabel.text = "\(Float(annotation.location.latitude)), \(Float(annotation.location.longitude))"
        
        return calloutView
    }
    
    // MARK: - Functions

    func getAnnotaions() -> [SKAnnotation] {
        var annotationArray: [SKAnnotation] = []
        let annotationOffSetYValue: CGFloat = 95
        let annotationOffSetXValue: CGFloat = 150
        
        let recyclingCentre1 = RecyclingCentre(title: "Street", subtitle: "0, 0", latitude: 46.770930, longitude: 23.598920, identifier: 1)
        let annotation1 = SKAnnotation.init()
        annotation1.location.latitude = CLLocationDegrees(recyclingCentre1.latitude)
        annotation1.location.longitude = CLLocationDegrees(recyclingCentre1.longitude)
        annotation1.identifier = recyclingCentre1.identifier
        annotation1.offset.x = annotationOffSetXValue
        annotation1.offset.y = annotationOffSetYValue
        annotation1.annotationType = SKAnnotationType.green
        annotationArray.append(annotation1)
        
        let recyclingCentre2 = RecyclingCentre(title: "Street", subtitle: "0, 0", latitude: 46.760430, longitude: 23.578720, identifier: 2)
        let annotation2 = SKAnnotation.init()
        annotation2.location.latitude = CLLocationDegrees(recyclingCentre2.latitude)
        annotation2.location.longitude = CLLocationDegrees(recyclingCentre2.longitude)
        annotation2.identifier = recyclingCentre2.identifier
        annotation2.offset.x = annotationOffSetXValue
        annotation2.offset.y = annotationOffSetYValue
        annotation2.annotationType = SKAnnotationType.green
        annotationArray.append(annotation2)
        
        let recyclingCentre3 = RecyclingCentre(title: "Street", subtitle: "0, 0", latitude: 46.750930, longitude: 23.548760, identifier: 3)
        let annotation3 = SKAnnotation.init()
        annotation3.location.latitude = CLLocationDegrees(recyclingCentre3.latitude)
        annotation3.location.longitude = CLLocationDegrees(recyclingCentre3.longitude)
        annotation3.identifier = recyclingCentre3.identifier
        annotation3.offset.x = annotationOffSetXValue
        annotation3.offset.y = annotationOffSetYValue
        annotation3.annotationType = SKAnnotationType.green
        annotationArray.append(annotation3)
        
        let recyclingCentre4 = RecyclingCentre(title: "Street", subtitle: "0, 0", latitude: 46.770930, longitude: 23.598870, identifier: 4)
        let annotation4 = SKAnnotation.init()
        annotation4.location.latitude = CLLocationDegrees(recyclingCentre4.latitude)
        annotation4.location.longitude = CLLocationDegrees(recyclingCentre4.longitude)
        annotation4.identifier = recyclingCentre4.identifier
        annotation4.offset.x = annotationOffSetXValue
        annotation4.offset.y = annotationOffSetYValue
        annotation4.annotationType = SKAnnotationType.green
        annotationArray.append(annotation4)
        
        let recyclingCentre5 = RecyclingCentre(title: "Street", subtitle: "0, 0", latitude: 46.778930, longitude: 23.585920, identifier: 5)
        let annotation5 = SKAnnotation.init()
        annotation5.location.latitude = CLLocationDegrees(recyclingCentre5.latitude)
        annotation5.location.longitude = CLLocationDegrees(recyclingCentre5.longitude)
        annotation5.identifier = recyclingCentre5.identifier
        annotation5.offset.x = annotationOffSetXValue
        annotation5.offset.y = annotationOffSetYValue
        annotation5.annotationType = SKAnnotationType.green
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
