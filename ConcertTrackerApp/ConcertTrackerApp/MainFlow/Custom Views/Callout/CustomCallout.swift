//
//  CustomCallout.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/30/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import MapKit

class CustomPin: NSObject, MKAnnotation {
    
    let event: Event
    var coordinate: CLLocationCoordinate2D {
        guard let coordinates = event.location?.coordinates?.coreLocationCoordinate2D else { preconditionFailure() }
        return coordinates
    }
    var title: String? {
        return event.displayName
    }
    var subtitle: String? {
        guard let startTime = event.start?.time else { return "Time is not set up yet!" }
        return "Starts at \(startTime)"
    }
    
    
    init(event: Event) {
        self.event = event
    }
    
}
