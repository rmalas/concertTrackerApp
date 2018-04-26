//
//  SearchVenueWithCityNameResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/23/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct SearchVenueByCityNameResults:Decodable {
    
    let resultsPage: VenueCityResultsPage?
    
}

struct VenueCityResultsPage: Decodable {

    let status: String
    let results: VenueCityResults
    let perPage: Int
    let page: Int
    let totalEntries: Int
    
    
}


struct VenueCityResults: Decodable {
    
    let location: [LocationsData]
}

struct LocationsData: Decodable {
    
    let city: CityDescr
    let metroArea:MetroArea
    
}

struct CityDescr: Decodable {

    
    let lat: Double?
    let lng: Double?
    let country: Country
    let displayName: String
    
}

struct MetroArea: Decodable {
    
    let lat: Double?
    let lng: Double?
    let country: Country
    let uri: String
    let displayName: String
    let id: Int
    
}

struct Country: Decodable {
    
    let displayName: String
    
}










