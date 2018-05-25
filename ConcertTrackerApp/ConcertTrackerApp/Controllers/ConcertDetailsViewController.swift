//
//  ConcertDetailsViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/30/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import MapKit
import EventKit

protocol ConcertDetailsDelegate: class {
    func goingButtonPressed()
}

class ConcertDetailsViewController: UIViewController {
    
    var upcommingName = ""
    var upCommingID = 0
    var coords: GeoCoordinates2D?
    var event: Event?
    
    //MARK: Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var eventCityLabel: UILabel!
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var detailInfoLabel: UILabel!
    @IBOutlet weak var concertStartTimeLabel: UILabel!
    @IBOutlet weak var ticketsPriceLabel: UILabel!
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        mapVC.concertCoordinates = event?.location?.coordinates?.coreLocationCoordinate2D
        navigationController?.pushViewController(mapVC, animated: true)
    }
    @IBAction func handleGoing(_ sender: UIButton) {
        createCalendarEvent()
    }
    
    @IBOutlet weak var concertMapView: MKMapView!
    
    @IBOutlet weak var profileNameLbl: UILabel!
    
    
    //MARK: lifecycle
    override func viewDidLoad() {

        super.viewDidLoad()
        RequestManager.shared.getEventDetails(eventID: upCommingID) { (event) in
//            self.coords?.latitude = event.location?.coordinates?.latitude ?? 0.0
//            self.coords?.longitude = event.location?.coordinates?.longitude ?? 0.0
            print("*****\(self.upCommingID)*******")
            print(event.location?.coordinates ?? "no city yet")
            DispatchQueue.main.async {
                self.coords = event.location?.coordinates
                self.artistNameLabel.text = self.upcommingName
                self.eventCityLabel.text = event.location?.city
                self.detailInfoLabel.text = event.displayName
                //self.coords = event.location?.coordinates?.coreLocationCoordinate2D
                if event.start?.time != nil {
                    self.concertStartTimeLabel.text = "Event starts at \(event.start?.time ?? "")"
                } else {
                    self.concertStartTimeLabel.text = "Time is not set up yet!"
                }
                self.setUpMap()
            }
        }
        profileImage.image = UIImage(named: upcommingName) ?? UIImage(named: "Rita Ora")
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
        setUpBackGround()
    }
    
    func setUpBackGround() {
        view.backgroundColor = SetUpColors.whiteColor
        title = "Concert info"
    }
    
    func setUpMap() {
        guard let event = event, let location = event.location?.coordinates else {
            return
        }
        
        let annotationPin = MKPointAnnotation()
        annotationPin.coordinate = location.coreLocationCoordinate2D
        var region = MKCoordinateRegion()
        region.center = location.coreLocationCoordinate2D
        region.span.latitudeDelta = 0.05
        region.span.longitudeDelta = 0.05
        concertMapView.addAnnotation(annotationPin)
        concertMapView.setRegion(region, animated: true)
    }
    
    
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: "Event", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createCalendarEvent() {
        let conertDisplayName = event?.displayName
        if let time = event?.start?.time,let date = event?.start?.date {
            let dateAndTime = date + time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
            let eventTimeInUTC = dateFormatter.date(from: dateAndTime)
            let calendarEvent = EKEventStore()
            calendarEvent.requestAccess(to: .event) { (permissionGranted, error) in
                if permissionGranted && error == nil  {
                    let event: EKEvent = EKEvent(eventStore: calendarEvent)
                    event.startDate = eventTimeInUTC
                    event.title = conertDisplayName
                    event.endDate = eventTimeInUTC?.addingTimeInterval(3600*3)
                    event.calendar = calendarEvent.defaultCalendarForNewEvents
                    self.showAlert(text: "is added to your iphone calendar")
                    do {
                        try calendarEvent.save(event, span: .thisEvent)
                    } catch  let error as NSError {
                        print(error)
                    }
                } else {
                    self.showAlert(text: "Something went wrong! \n Event is not added to your calendar")
                }
            }
        } else {
            self.showAlert(text: "Time is not set up for this event.\n Detail info comes soon!")
        }
    }
    
}


extension ConcertDetailsViewController: ConcertDetailsDelegate {
    func goingButtonPressed() {
        let ctrl = UIAlertController(title: "Add event to calendar", message: "blabla", preferredStyle: .alert)
        ctrl.addAction(UIAlertAction(title: "Add", style: .default, handler: { (alert) in
            self.createCalendarEvent()
        }))
        ctrl.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ctrl, animated: true, completion: nil)
    }
    
    
}









