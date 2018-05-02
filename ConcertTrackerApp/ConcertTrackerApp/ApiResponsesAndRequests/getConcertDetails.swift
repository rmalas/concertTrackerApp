//
//  getConcertDetails.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/28/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct Conecert_ResultsPage:Decodable {
    let resultsPage: Concert_Results
}

struct Concert_Results: Decodable {
    let status: String
    let results: Concert_DetailResults
    let perPage: Int
    let page: Int
    let totalEntries: Int
}

struct Concert_DetailResults:Decodable {
    let event: [Event]?
}

struct Performance:Decodable {
    let displayName: String?
}

struct Event: Decodable {
    let type: String?
    let popularity: Double?
    let displayName: String?
    let start: Start?
    let location: Location?
    let id: Int?
    let performance: [Performance]?
}

struct Start: Decodable {
    let time: String?
    let date: String?
}
struct Location: Decodable {
    let city: String?
    let lat: Double?
    let lng: Double?
}
