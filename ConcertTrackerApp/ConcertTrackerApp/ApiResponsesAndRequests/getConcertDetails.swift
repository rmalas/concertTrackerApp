//
//  getConcertDetails.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/28/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import CoreLocation

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
    var city: String?
    var coordinates: CLLocationCoordinate2D?
    enum CodingKeys: String,CodingKey {
        case city
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let city = try container.decode(String.self, forKey: .city)
        let lng = try container.decode(Double.self, forKey: .lng)
        let lat = try container.decode(Double.self, forKey: .lat)
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.init(city: city, coordinate: coordinates)
    }
    init() {}
    init(city:String?, coordinate: CLLocationCoordinate2D) {
        self.init()
        self.city = city
        coordinates = coordinate
    }
    
    
//    let lat: Double?
//    let lng: Double?
}
