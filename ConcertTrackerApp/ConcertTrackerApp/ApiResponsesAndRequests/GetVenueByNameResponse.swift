//
//  GetVenueByNameResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/21/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import ObjectMapper

class VenueSearchResultsPage: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        resultsPage <- map["resultsPage"]
    }
    
    var resultsPage: ResultsInfo?
    
}


class ResultsInfo:Mappable {
    required init?(map: Map) {  }
    
    func mapping(map: Map) {
        status <- map["status"]
        results <- map["results"]
        perPage <- map["perPage"]
        page <- map["page"]
        totalEntries <- map["totalEntries"]
    }
    
    var status: String?
    var results: VenueResults?
    var perPage: Int?
    var page: Int?
    var totalEntries:Int?
}

class venueArray: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        venue <- map ["venue"]
    }
    
    var venue: [VenueResults]?
    
    
}

class VenueResults:Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lng <- map["lng"]
        capacity <- map["capacity"]
        zip <- map["zip"]
        description <- map["description"]
        street <- map["street"]
        displayName <- map["displayName"]
        webSite <- map["webSite"]
        city <- map["city"]
        uri <- map["uri"]
        id <- map["id"]
        metroArea <- map["metroArea"]
        phone <- map["phone"]
        lat <- map["lat"]
        
    }
    
    var lng:Double?
    var capacity: Int?
    var zip: String?
    var description: String?
    var street: String?
    var displayName: String?
    var webSite: String?
    var city: CityDescription?
    var uri: String?
    var id: Int?
    var metroArea: MetroAreaDescription?
    var phone: String?
    var lat: Double?
}

class CityDescription: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        displayName <- map["displayName"]
        uri <- map["uri"]
        id <- map["id"]
        country <- map["country"]
    }
    
    var displayName: String?
    var uri: String?
    var id: Int?
    var country: CountryDescription?
    var state: State?
    
}

class State: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        state <- map["state"]
    }
    
    
    
    var state: String?
}


class CountryDescription: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        displayName <- map["displayName"]
    }
    
    var displayName: String?
    
}

class MetroAreaDescription:Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        displayName <- map["displayName"]
        uri <- map["uri"]
        id <- map["id"]
        country <- map["country"]
    }
    
    var displayName: String?
    var uri: String?
    var id: String?
    var country: CountryDescription?
    
}

















