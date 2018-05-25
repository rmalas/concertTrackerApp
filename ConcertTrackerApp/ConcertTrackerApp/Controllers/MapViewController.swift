//
//  MapViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/2/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var concertCoordinates: CLLocationCoordinate2D?

    @IBOutlet weak var concertMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(concertCoordinates?.latitude,concertCoordinates?.longitude)
        guard let coords = concertCoordinates else { return }
        setAnnotationPin(coordinates: coords)
    }

    
    func setAnnotationPin(coordinates: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = coordinates.latitude
        annotation.coordinate.longitude = coordinates.longitude
        concertMapView.addAnnotation(annotation)
        
        var region = MKCoordinateRegion()
        region.center.latitude = coordinates.latitude
        region.center.longitude = coordinates.longitude
        region.span.latitudeDelta = 0.5
        region.span.longitudeDelta = 0.5
        concertMapView.setRegion(region, animated: true)
        
    }

}
