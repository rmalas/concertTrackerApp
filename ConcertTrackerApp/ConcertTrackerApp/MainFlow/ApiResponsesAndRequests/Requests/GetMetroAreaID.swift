//
//  GetMetroAreaID.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetMetroAreaID: SongKickAbstractRequest {
    var cityName: String?
    
    override var url: String {
            return "search/locations.json"
    }
    
    override var urlParams: [String : String]? {
        var queryParameters = [String: String]()
        if let cityQuery = cityName {
            queryParameters["query"] = cityQuery
        }
        return queryParameters
    }
}
