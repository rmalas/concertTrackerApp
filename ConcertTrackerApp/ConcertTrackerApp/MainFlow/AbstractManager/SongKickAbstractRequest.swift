//
//  AbstractRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/20/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Alamofire

struct SongKickConstants {
    struct API {
        static let key = "io09K9l3ebJxmxe2"
    }
    //спершу шукаємо metroArea ID
    //https://api.songkick.com/api/3.0/search/locations.json?query=London&apikey={your_api_key}

    //24426
    //по metroArea ID
    //https://www.songkick.com/developer/upcoming-events-for-metro-area
}

enum HTTPRequestMethod {
    case get
    case post
}


class SongKickAbstractRequest {
    var baseUrl = "http://api.songkick.com/api/3.0/"
    var url: String {
        get {
            return ""
        }
    }
    var apiKey = SongKickConstants.API.key
    
    var urlParams: [String: String]? {
        get {
            return nil
        }
    }
    
    var requestUrl: String {
        get {
            var urlParameters = urlParams ?? [String: String]()
            urlParameters["apikey"] = apiKey
            let paramsStrings = urlParameters.map { (parameter) -> String in
                let urlParam = "\(parameter.key)=\(parameter.value)"
                guard let urlParamEncoded = urlParam.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    return urlParam
                }
                return urlParamEncoded
            }
            let separator = paramsStrings.count > 0 ? "?" : ""
            let queryParams = paramsStrings.joined(separator: "&")
            return baseUrl + url + separator + queryParams
        }
    }
}



class GetEventDetails: SongKickAbstractRequest {
    var eventId: Int?
    
    override var url: String {
        guard let eventId = eventId else {
            return ""
        }
        return "\(eventId).json"
    }
}

class Failure: Error {
    var code: Int?
    var message: String?
    
    convenience init(code: Int? = nil, message: String? = nil) {
        self.init()
        self.code = code
        self.message = message
    }
}

