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
    
    override func getdata(artistName name: String)  {
        let request = GetArtistByNameRequest()
        request.artistQuery = name
        guard let url = URL(string: request.requestUrl) else { return }
        Alamofire.request(url).responseString { (response) in
            switch (response.result) {
            case .success(let responseString):
                if let responseWithParsedData = SearchArtistResponse(JSONString: responseString) {
                    Helper.shared.someArtistsArray.append(responseWithParsedData)
                    print(responseWithParsedData.resultsPage?.perPage as! Int)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
