//
//  ConcertDetailsViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/30/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import MapKit

class ConcertDetailsViewController: UIViewController {
    
    var upcommingName = ""
    var upCommingID = 0
    var coords: CLLocationCoordinate2D?
    var event: EventDetails_EventInfo?
    
    @IBOutlet weak var concertTableView: UITableView!
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.concertCoordinates = coords
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBOutlet weak var concertMapView: MKMapView!
    
    @IBOutlet weak var profileNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RequestManager.shared.getEventDetails(eventID: upCommingID) { (event) in
            print(event.location?.city ?? "no city yet")
            guard let parsedLatitude = event.location?.lat, let parsedLongitude = event.location?.lng else { return }
            DispatchQueue.main.async {
                self.self.coords = CLLocationCoordinate2D(latitude: parsedLatitude, longitude: parsedLongitude)
                self.setUpMap(coords: self.coords!)
                self.event = event
                self.concertTableView.reloadData()
            }
        }
        self.concertTableView.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
        navigationItem.title = "Concert info"
        setUpBackGround()
    }
    
    func setUpBackGround() {
        view.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
    }
    
    func setUpMap(coords: CLLocationCoordinate2D) {
        let annotationPin = MKPointAnnotation()
        annotationPin.coordinate.latitude = coords.latitude
        annotationPin.coordinate.longitude = coords.longitude
        var region = MKCoordinateRegion()
            region.center.latitude = coords.latitude
            region.center.longitude = coords.longitude
            region.span.latitudeDelta = 0.05
            region.span.longitudeDelta = 0.05
        concertMapView.addAnnotation(annotationPin)
        concertMapView.setRegion(region, animated: true)
    }

}

extension ConcertDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height - concertMapView.frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertCell",for: indexPath) as! ConcertDetailsTableViewCell
        cell.selectionStyle = .none
        cell.profileImage.image = UIImage(named: "\(upcommingName)")
        cell.nameLbl.text = upcommingName
        cell.infoLbl.text = event?.location?.city ?? "no value"
        cell.concertStartTime.text = "  Concert starts at \(event?.start?.time ?? "time is not set yet")"
        cell.ticketsPrice.text = "  Avg ticket price is: 45-85$"
        cell.additionalInfoLbl.text = event?.displayName
        return cell
    }
    
    
    
    
}










