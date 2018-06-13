//
//  MapViewController.swift
//  EcoPlanner
//
//  Created by user on 25/04/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit
import SKMaps

let kDefaultLocation = CLLocationCoordinate2D(latitude: 46.770976, longitude: 23.596891)
let kDefaultZoomLevel: Float = 14
let kAnimationDuration: Float = 0.3

class MapViewController: UIViewController, SKMapViewDelegate, SKCalloutViewDelegate {

    @IBOutlet weak var mapView: SKMapView!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = kBlueColor
        RemindersViewController.addShadowsTo(view: (navigationController?.navigationBar)!, withOffSet: 2.0)
        RemindersViewController.addShadowsTo(view: (tabBarController?.tabBar)!, withOffSet: -2.0)
        
        self.mapView.delegate = self
        self.mapView.settings.osmAttributionPosition = .bottomLeft
        self.mapView.settings.companyAttributionPosition = .bottomLeft
        
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
    
    func mapView(_ mapView: SKMapView, didSelect annotation: SKAnnotation) {
        self.mapView.showCallout(atLocation: annotation.location, withOffset: CGPoint(x: 0, y: 42.0), animated: true)
        self.mapView.calloutView.titleLabel.text = RecyclingCentre.recyclingCentreForIdentifier(identifier: annotation.identifier)?.title
        self.mapView.calloutView.subtitleLabel.text = RecyclingCentre.recyclingCentreForIdentifier(identifier: annotation.identifier)?.subtitle
        self.mapView.calloutView.rightButton.isHidden = true
        self.mapView.calloutView.delegate = self
    }
    
    func mapView(_ mapView: SKMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.mapView.hideCallout()
    }
    
    func mapView(_ mapView: SKMapView, didStartRegionChangeFrom region: SKCoordinateRegion) {
        self.locationButton.isEnabled = true
        self.locationButton.isHidden = false
    }
    
    // MARK: - CalloutView
    
    func calloutView(_ calloutView: SKCalloutView!, didTapRightButton rightButton: UIButton!) {
        
    }
    
    func calloutView(_ calloutView: SKCalloutView!, didTapLeftButton leftButton: UIButton!) {
        SKRoutingService.sharedInstance().mapView = self.mapView
        SKRoutingService.sharedInstance().clearCurrentRoutes()
        
        let routeSettings = SKRouteSettings()
        routeSettings.startCoordinate = SKPositionerService.sharedInstance().currentCoordinate
        routeSettings.destinationCoordinate = calloutView.location
        routeSettings.routeMode = .pedestrian
        
        SKRoutingService.sharedInstance().calculateRoute(routeSettings)
    }
    
    // MARK: - Actions

    @IBAction func didTapLocationButton(_ sender: Any) {
        self.locationButton.backgroundColor = kClearColor
        self.mapView.animate(toLocation: SKPositionerService.sharedInstance().currentCoordinate, withPadding: .init(), duration: kAnimationDuration)
        self.locationButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(kAnimationDuration)) {
            self.mapView.animate(toZoomLevel: kDefaultZoomLevel)
            self.locationButton.isHidden = true
        }
    }
    
    // MARK: - Private Functions

    private func getRegion() -> SKCoordinateRegion {
        let coordinate = SKPositionerService.sharedInstance().currentCoordinate
        var region = SKCoordinateRegion.init()
        
        if coordinate.latitude == 0 && coordinate.longitude == 0 {
            region = SKCoordinateRegion(center: kDefaultLocation, zoomLevel: 8)
        } else {
            region = SKCoordinateRegion(center: coordinate, zoomLevel: kDefaultZoomLevel)
        }
        
        return region
    }
    
    private func getAnnotaions() -> [SKAnnotation] {
        var annotationArray: [SKAnnotation] = []
        let recyclingCentres: [RecyclingCentre] = RecyclingCentre.getRecyclingCentres()
        
        for centre in recyclingCentres {
            let annotation = SKAnnotation.init()
            
            annotation.location.latitude = CLLocationDegrees(centre.latitude)
            annotation.location.longitude = CLLocationDegrees(centre.longitude)
            annotation.identifier = centre.identifier
            annotation.annotationType = SKAnnotationType.purple
            
            annotationArray.append(annotation)
        }
        
        return annotationArray
    }
    
}
