//
//  SearchArtistResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Alamofire


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


