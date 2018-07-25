//
//  MapViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/2/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    
    var events = DatabaseManager.shared.objects(Event.self)
    
    var upcommingEvents: [Event] = []
    
    

    @IBOutlet weak var concertMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnnotationsForConcerts(arrayOfEvents: upcommingEvents)
    }
    

    func setAnnotationsForConcerts(arrayOfEvents events: [Event]) {
        
        if !events.isEmpty {
            guard let coords = events[0].location?.coordinates?.coreLocationCoordinate2D else { return }
            var region = MKCoordinateRegion()
            region.center =  coords
            region.span.latitudeDelta = 0.5
            region.span.longitudeDelta = 0.5
            concertMapView.setRegion(region, animated: true)
            
            
            events.forEach { (event) in
                let annotation = CustomPin(event: event)
                
                self.concertMapView.addAnnotation(annotation)
            }
        }
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
        let infoButton = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = infoButton
        annotationView.image = UIImage(named:"pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            print(123)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    
    

}
