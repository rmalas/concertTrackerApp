//
//  Requests.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/26/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetVenueByCityNameRequest: AbstractRequest {
    var artistQuery: String?
    override var url: String {
        return "search/locations.json"
    }
    override var urlParams: [String : String]? {
        var queryParameters = [String:String]()
        if let artistQuery = artistQuery {
            queryParameters["query"] = artistQuery
        }
        return queryParameters
    }
}

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

class GetArtistByNameRequest: AbstractRequest {
    var artistQuery: String?
    
    override var url: String {
        return "search/artists.json"
    }
    
    override var urlParams: [String : String]? {
        var queryParameters = [String: String]()
        if let artistQuery = artistQuery {
            queryParameters["query"] = artistQuery
        }
        return queryParameters
    }
}
