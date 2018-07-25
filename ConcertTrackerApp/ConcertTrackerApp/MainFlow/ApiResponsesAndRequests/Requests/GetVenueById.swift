//
//  GetVenueById.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/22/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation


class GetVenueById: SongKickAbstractRequest
{
    var venueId: Int?
    override var url: String {
        guard let venueId = venueId else {
            preconditionFailure("venueId is nil")
        }
        return "artists/\(venueId)/calendar.json"
    }
}
