//
//  GetArtistUpcomingEventsRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/10/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetArtistUpcomingEventsRequest: AbstractRequest
{
    var artistId: Int?
    override var url: String {
        guard let artistId = artistId else {
            preconditionFailure("artistId is nil")
        }
        return "artists/\(artistId)/calendar.json"
    }
}
