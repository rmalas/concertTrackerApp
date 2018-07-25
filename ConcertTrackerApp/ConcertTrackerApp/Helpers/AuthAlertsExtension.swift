//
//  AuthAlertsExtension.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/10/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

extension ConcertTrackerAlertController {
    static var emailAlreadyExistsAlert: ConcertTrackerAlertController {
        return ConcertTrackerAlertController(title: "Error", message: "User with this email already exists!")
    }
    
    static var permissionDeniedAlert: ConcertTrackerAlertController {
        return ConcertTrackerAlertController(title: "Permission denied", message: "Password or email is incorrect")
    }
    
    static var eventCreatedAlert: ConcertTrackerAlertController {
        return ConcertTrackerAlertController(title: "Event created", message: "Check it our in your iphone calendar!")
    }
    
    static var timeForThisEventIsNotSetup: ConcertTrackerAlertController {
        return ConcertTrackerAlertController(title: "Come back soon", message: "Time is not set up yet!")
    }
    
    static var somethingWentWrongEvent: ConcertTrackerAlertController {
        return ConcertTrackerAlertController(title: "Something went wrong", message: "Alert is not added to your calendar")
    }
}
