//
//  Details.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/25/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import MapKit


struct EventDetails_ResultsPage: Decodable {
    let resultsPage: EventDetails_Info
}

struct EventDetails_Info: Decodable {
    let status: String
    let results: EventDetails_Event?
}

struct EventDetails_Event: Decodable {
    let event: EventDetails_EventInfo?
}

struct EventDetails_EventInfo: Decodable {
    let type: String?
    let popularity: Double?
    let displayName: String?
    let status: String?
    let id: Int?
    let start: Start?
    let location: Location?
}

