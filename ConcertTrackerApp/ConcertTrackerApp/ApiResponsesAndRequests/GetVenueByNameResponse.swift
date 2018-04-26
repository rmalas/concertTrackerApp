//
//  GetVenueByNameResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/21/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct VenuesSearch_ResultsPage:Decodable {
    let resultsPage: VenuesSearch_Info
}

struct VenuesSearch_Info: Decodable {
    let status: String?
    let results: VenuesSearch_Results?
    let perPage: Int?
    let page:Int?
    let totalEntries:Int?
}

struct VenuesSearch_Results: Decodable {
    let venue: [VenuesSearch_Venue]?
}

struct VenuesSearch_Venue: Decodable {
    let lng: Double?
    let capacity: Int?
    let zip: String
    let description: String
    let street: String
    let displayName: String
    let website: String?
    let city:VenuesSearch_City
    let uri: String
    let id: Int
    let metroArea: VenuesSearch_MetroArea
    let phone: String?
    let lat: Double?
}

struct VenuesSearch_City: Decodable {
    let displayName: String
    let uri: String
    let id: Int
    let country: VenuesSearch_Country
}

struct VenuesSearch_Country:Decodable {
    let displayName: String
}

struct VenuesSearch_MetroArea:Decodable {
    let displayName: String
    let uri: String
    let id: Int
    let country: VenuesSearch_Country

}




















