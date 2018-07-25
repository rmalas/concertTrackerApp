//
//  Festival.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/21/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct FestResults:Decodable {
    var resultsPage: FestivalResultsPage
}

struct FestivalResultsPage: Decodable {
    let status: String
    var results: FestivalResults
}

struct FestivalResults: Decodable {
    var event: EventDescription
}

struct EventDescription: Decodable {
    let type: String
    let popularity: Double
    let displayName: String
    let status: String
    var performance: [FestPermormance]
    let ageRestriction: Int?
    let start: Start
    let location: Location
    let uri: String?
    let id: Int?
}


struct FestPermormance: Decodable {
    var displayName: String?
    var artistImageURL:String?
        
}
