//
//  GetSimilarArtistRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetSimilarArtistRequest: SongKickAbstractRequest {
    var artistId: Int?
    var perPage: Int?
    
    override var url: String {
        guard let artistId = artistId else {
            preconditionFailure("artistId is nil")
        }
        return "artists/\(artistId)/similar_artists.json"
    }
    
    override var urlParams: [String : String]? {
        var queryParameters = [String: String]()
        if let artistQuery = perPage {
            queryParameters["per_page"] = String(artistQuery)
        }
        return queryParameters
    }
}
