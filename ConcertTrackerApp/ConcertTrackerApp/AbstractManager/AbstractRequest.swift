//
//  AbstractRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/20/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Alamofire

struct Constants {
    struct API {
        static let key = "io09K9l3ebJxmxe2"
    }
}

enum HTTPRequestMethod {
    case get
    case post
}

class AbstractRequest {
    var method: HTTPRequestMethod? {
        return .get
    }
    var baseUrl = "http://api.songkick.com/api/3.0/"
    var url: String {
        get {
            return ""
        }
    }
    var apiKey = Constants.API.key
    
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
    
    func getdata(artistName name: String) throws {
        
    }
}








class GetEventDetails: AbstractRequest {
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

class RequestManager {
    static let shared = RequestManager()
    
    
    func searchArtist(byName name: String) throws {
        let request = GetArtistByNameRequest()
        request.artistQuery = name
        guard let url = URL(string: request.requestUrl) else { throw Failure(message: "Invalid request URL") }
        Alamofire.request(url).responseString { (response) in
            switch (response.result) {
            case .success(let responseString):
                if let responseWithParsedData = SearchArtistResponse(JSONString: responseString) {
                    Helper.shared.someArtistsArray.append(responseWithParsedData)
                    print(Helper.shared.someArtistsArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func searchArtist(byName name:String) throws {
//        let request = GetArtistByNameRequest()
//        request.artistQuery = name
//        guard let url = URL(string: request.requestUrl) else {
//            throw Failure(message: "Invalid request URL")
//        }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            }.resume()
//    }
}








