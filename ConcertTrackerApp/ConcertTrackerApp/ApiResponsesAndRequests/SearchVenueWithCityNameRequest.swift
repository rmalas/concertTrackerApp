//
//  SearchVenueWithCityNameRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/23/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Alamofire

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
    
    override func getdata(artistName name: String) {
        let request = GetVenueByNameRequest()
        request.artistQuery = name
        guard let url = URL(string: request.requestUrl) else { return }
        Alamofire.request(url).responseString { (response) in
            switch(response.result) {
            case .success(let responseString):
                if let responseStringWithParsedData = SearchVenueByNameResults(JSONString: responseString) {
                    print(responseStringWithParsedData.resultPage?.page ?? "no value")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
