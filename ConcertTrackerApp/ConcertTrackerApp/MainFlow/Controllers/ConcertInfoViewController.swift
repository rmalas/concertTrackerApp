//
//  ConcertInfoViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/11/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import MapKit
import EventKit

class ConcertInfoViewController: UIViewController,AlertPresenter {
    //MARK: Outlets
    @IBOutlet weak var mainConcertInfo: UILabel!
    @IBOutlet weak var additionalConcertInfo: UILabel!
    @IBOutlet weak var concertMapView: MKMapView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var concertAtCityLabel: UILabel!
    
    @IBAction func iAmGoingButtonPressed(_ sender: UIButton) {
        createCalendarEvent()
    }
    
    var conertId = 0
    var event: Event? {
        didSet{
            setUpLabelsWithData()
            setUpMapView()
        }
    }
    
    
    func setUpLabelsWithData() {
        guard let info = event?.displayName else { return }
        
        mainConcertInfo.text = info
        if let time = event!.start?.time {
            additionalConcertInfo.text = "Event starts at \(time)"
        } else {
            additionalConcertInfo.text = "Time is not set up yet!"
        }
        
        guard let location = event?.location?.city else { return }
        concertAtCityLabel.text = location
        
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
                    self.showAlert(.eventCreatedAlert)
                    do {
                        try calendarEvent.save(event, span: .thisEvent)
                    } catch  let error as NSError {
                        print(error)
                    }
                } else {
                    self.showAlert(.eventCreatedAlert)
                }
            }
        } else {
            self.showAlert(.timeForThisEventIsNotSetup)
        }
    }
    
    
    
    
    
    func setUpMapView() {
        guard let coordintes = event?.location?.coordinates?.coreLocationCoordinate2D else { return }
        
        let annotation = MKPointAnnotation()
        var region = MKCoordinateRegion()
        region.center = coordintes
        region.span.latitudeDelta = 0.05
        region.span.longitudeDelta = 0.05
        
        annotation.coordinate = coordintes
        concertMapView.addAnnotation(annotation)
        concertMapView.setRegion(region, animated: true)
        
        print(coordintes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Concert"
        RequestManager.shared.getEventDetails(eventID: conertId) { (event) in
            self.event = event
        }
        
    }


}
