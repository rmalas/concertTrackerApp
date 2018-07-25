//
//  MetroArea.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct MetroAreaDecoder:Decodable {
    let resultsPage: MetroAreaResultsPage
}

struct MetroAreaResultsPage: Decodable {
    let status: String
    let results: MetroAreaResults
    let perPage: Int
    let page: Int
    let totalEntries: Int
}

struct MetroAreaResults: Decodable {
    let location: [MetroAreaLocation]
}

struct MetroAreaLocation: Decodable {
    let city: MetroAreaCity
    let metroArea: MetroArea
}

struct MetroAreaCity:Decodable {
    let lat: Double
    let lng: Double
    let country: Country
    let displayName: String
}




