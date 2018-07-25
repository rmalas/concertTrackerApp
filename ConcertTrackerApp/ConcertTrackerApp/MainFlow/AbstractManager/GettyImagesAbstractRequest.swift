//
//  GettyImagesAbstractRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/4/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct GettyImagesConstants {
    struct API {
        static let apiKey = "v52jqqk96b2jzd9p94af47rz"
    }
}

class GettyImagesAbstractRequest {
    var baseUrl = "https://api.gettyimages.com/v3/search/"
    
    //images?phrase=acdc&fields=preview
    
    var url: String {
        get {
            return ""
        }
    }
    
    var apiKey = GettyImagesConstants.API.apiKey
    
    var urlParams: [String: String]? {
        get {
            return nil
        }
    }
    
    var requestUrl: String {
        get {
            var urlParameters = urlParams ?? [String: String]()
            
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
