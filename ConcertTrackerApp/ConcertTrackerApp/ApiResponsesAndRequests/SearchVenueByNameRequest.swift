//
//  SimilarArtistsRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/20/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Alamofire


class GetVenueByNameRequest: AbstractRequest {
    var artistQuery: String?
    override var url: String {
        return "search/venues.json"
    }
    
    override var urlParams: [String : String]? {
        var queryParameters = [String:String]()
        if let artistQuery = artistQuery {
            queryParameters["query"] = artistQuery
        }
        return queryParameters
    }
}
