//
//  searchSimilarArtistResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import ObjectMapper

class ResultsPage: Mappable{
    var status: String?
    var results: SimilarResults?
    var perPage: Int?
    var page: Int?
    var totalEntries: Int?
    
    
    required init?(map: Map) {  }
    
    func mapping(map: Map) {
        results      <- map["resultsPage"]
        status       <- map["status"]
        perPage      <- map["perPage"]
        page         <- map["page"]
        totalEntries <- map["totalEntries"]
    }
}

class SimilarResults:Mappable {
    
    var artists: [Artist]?
    
    required init?(map: Map) {  }
    
     func mapping(map: Map) {
        artists <- map["artist"]
    }
    
    
}


class Artist: Mappable {
    
    var displayName: String?
    var identifier: String?
    var uri: String?
    var onTourUntil: String?
    var id: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        displayName <- map["displayName"]
        identifier <- map["identifier"]
        uri <- map["uri"]
        onTourUntil <- map["onTourUntil"]
        id <- map["id"]
    }
    
    
}
