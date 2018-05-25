//
//  Requests.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/26/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetEventByIdRequest : AbstractRequest {
    
    var eventId: Int?
    override var url: String {
        guard let eventId = eventId else {
            preconditionFailure("artistId is nil")
        }
        return "events/\(eventId).json"
    }
    
}

