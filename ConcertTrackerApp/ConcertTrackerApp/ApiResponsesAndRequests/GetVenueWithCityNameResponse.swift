//
//  SearchVenueWithCityNameResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/23/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchVenueByNameResults:Mappable {
    
    var resultPage: VenueCityResultsPage?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        resultPage <- map["resultsPage"]
    }
}

class VenueCityResultsPage: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        results <- map["results"]
        perPage <- map["perPage"]
        page <- map["page"]
        totalEntries <- map ["totalEntries"]
    }

    var status: String?
    var results: [VenueCityResultsArray]?
    var perPage: Int?
    var page: Int?
    var totalEntries: Int?
    
    
}


class VenueCityResultsArray: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        location <- map["location"]
    }
    
    var location: [LocationsData]?
}

class LocationsData: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        city <- map["city"]
        metroArea <- map["metroArea"]
    }
    
    var city: CityDescr?
    var metroArea:MetroArea?
    
}

class CityDescr: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
        country <- map["country"]
        displayName <- map["displayName"]
        
    }
    
    var lat: Double?
    var lng: Double?
    var country: Country?
    var displayName: String?
    
}

class MetroArea: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
        country <- map["country"]
        uri <- map["uri"]
        displayName <- map["displayName"]
        id  <- map["id"]
    }
    
    var lat: Double?
    var lng: Double?
    var country: Country?
    var uri: String?
    var displayName: String?
    var id: Int?
    
}

class Country: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        displayName <- map["displayName"]
    }
    
    var displayName: String?
    
}










