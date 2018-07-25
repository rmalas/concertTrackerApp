//
//  GetCityEventsRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetCityEventsRequest: SongKickAbstractRequest {
    var metroAreaID: Int?
    
    override var url: String {
        guard let metroAreaID = metroAreaID else { preconditionFailure("can't get metroArea ID") }
        
        return "metro_areas/\(metroAreaID)/calendar.json"
        
    }
}
