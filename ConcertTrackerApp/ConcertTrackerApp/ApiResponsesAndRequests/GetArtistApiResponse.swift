//
//  SearchArtistApiResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchArtistResponse:Mappable {

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        resultsPage <- map["resultsPage"]
    }
    
    var resultsPage: ArtistResult?
    
}

class ArtistResult: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status       <- map["status"]
        results      <- map["results"]
        perPage      <- map["perPage"]
        page         <- map["page"]
        totalEntries <- map["totalEntries"]
    }
    
    
    var status: String?
    var results: Results?
    var perPage: Int?
    var page: Int?
    var totalEntries: Int?
    
    
    
}

class Results:Mappable {
    
    var artistsInfo: [Info]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        artistsInfo <- map["artist"]
    }
}

class Info: Mappable {
    
    var displayName: String?
    var identifier: [Identifier]?
    var uri: String?
    var onTouruntil: String?
    var id: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        displayName <- map["displayName"]
        uri         <- map["uri"]
        identifier  <- map["identifier"]
        id          <- map["id"]
        onTouruntil <- map["onTourUntil"]
    }
}

class Identifier: Mappable {
    
    var href: String?
    var eventsHref: String?
    var mbid: String?
    var setListsHref: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        href         <- map["href"]
        eventsHref   <- map["eventsHref"]
        mbid         <- map["mbid"]
        setListsHref <- map["setListsHref"]
    }
}









