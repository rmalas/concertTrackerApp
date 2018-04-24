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
    
    override func getdata(artistName name: String)  {
        let request = GetVenueByNameRequest()
        request.artistQuery = name
        guard let url = URL(string: request.requestUrl) else { return }
        Alamofire.request(url).responseString { (response) in
            switch (response.result) {
            case .success(let responseString):
                if let responseStringWithParsedData = VenueSearchResultsPage(JSONString: responseString) {
                    print(responseStringWithParsedData.resultsPage?.totalEntries ?? "no value set for now")
                    print(responseStringWithParsedData.resultsPage?.results?.city?.country?.displayName ?? "no value set for now")
                    Helper.shared.VenyeDetailsArray.append(responseStringWithParsedData)
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
}
