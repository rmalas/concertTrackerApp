//
//  CityEvent.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct CityEventsResultsPage: Decodable {
    let resultsPage: CityEventsResults
}

struct CityEventsResults: Decodable {
    let status: String
    let results: CityEvents
    let perPage: Int
    let page: Int
    let totalEntries: Int
}

struct CityEvents: Decodable {
    let event: [DecodedEvents]
}

struct DecodedEvents: Decodable {
    let venue: DecodedVenue
    let type: String
    let status: String
    let performance: [Performance]
    let start: Start
    let popularity:Double?
    let location: Location
    let displayName:String
    let uri: String?
    let id: Int
}

struct DecodedVenue: Decodable {
    let displayName: String
    let uri: String?
    let metroArea: MetroArea
    let lng: Double?
    let lat: Double?
    let id: Int?
}
