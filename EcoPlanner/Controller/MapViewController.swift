//
//  MapViewController.swift
//  EcoPlanner
//
//  Created by user on 25/04/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import SKMaps

class MapViewController: UIViewController, SKMapViewDelegate, SKCalloutViewDelegate {

    @IBOutlet weak var mapView: SKMapView!
    @IBOutlet weak var locationButton: UIBarButtonItem!
    
    let defaultLocation = CLLocationCoordinate2D(latitude: 46.770976, longitude: 23.596891)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kGreenColor
        self.mapView.delegate = self
        
        SKPositionerService.sharedInstance().startLocationUpdate()
        
        self.mapView.visibleRegion = self.getRegion()

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
    
    func mapView(_ mapView: SKMapView, calloutViewFor annotation: SKAnnotation) -> UIView? {
        let calloutView = SKCalloutView()
        
        calloutView.titleLabel.text = RecyclingCentre.recyclingCentreForIdentifier(identifier: annotation.identifier)?.title
        calloutView.subtitleLabel.text = "\(Float(annotation.location.latitude)), \(Float(annotation.location.longitude))"
        
        return calloutView
    }
    
    func mapView(_ mapView: SKMapView, didSelect annotation: SKAnnotation) {
        self.mapView.hideCallout()
        self.mapView.showCallout(for: annotation, withOffset: CGPoint(x: 150, y: 95), animated: true)
    }
    
    func mapView(_ mapView: SKMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.mapView.hideCallout()
    }
    
    func mapView(_ mapView: SKMapView, didStartRegionChangeFrom region: SKCoordinateRegion) {
        self.locationButton.isEnabled = true
    }
    
    // MARK: - CalloutView
    
    func calloutView(_ calloutView: SKCalloutView!, didTapRightButton rightButton: UIButton!) {
        
    }
    
    func calloutView(_ calloutView: SKCalloutView!, didTapLeftButton leftButton: UIButton!) {
        let routingService = SKRoutingService.init()
        routingService.mapView = self.mapView
        
        let routeSettings = SKRouteSettings.init()
        routeSettings.startCoordinate = SKPositionerService.sharedInstance().currentCoordinate
        routeSettings.destinationCoordinate = calloutView.location
    }
    
    // MARK: - Actions

    @IBAction func didTapLocationButton(_ sender: Any) {
        self.mapView.animate(toLocation: SKPositionerService.sharedInstance().currentCoordinate, withPadding: .init(), duration: 0.3)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.mapView.animate(toZoomLevel: 14)
        }
        
        self.locationButton.isEnabled = false
    }
    
    // MARK: - Functions

    func getRegion() -> SKCoordinateRegion {
        let coordinate = SKPositionerService.sharedInstance().currentCoordinate
        var region = SKCoordinateRegion.init()
        
        if coordinate.latitude == 0 && coordinate.longitude == 0 {
            region = SKCoordinateRegion(center: defaultLocation, zoomLevel: 8)
        } else {
            region = SKCoordinateRegion(center: coordinate, zoomLevel: 14)
        }
        
        return region
    }
    
    func getAnnotaions() -> [SKAnnotation] {
        var annotationArray: [SKAnnotation] = []
        let recyclingCentres: [RecyclingCentre] = RecyclingCentre.getRecyclingCentres()
        
        for centre in recyclingCentres {
            let annotation = SKAnnotation.init()
            
            annotation.location.latitude = CLLocationDegrees(centre.latitude)
            annotation.location.longitude = CLLocationDegrees(centre.longitude)
            annotation.identifier = centre.identifier
            annotation.annotationType = SKAnnotationType.green
            
            annotationArray.append(annotation)
        }
        
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
