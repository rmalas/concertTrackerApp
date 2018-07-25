//
//  ArtistImage.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/4/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

struct ImageResults: Decodable {
    let result_count: Int?
    let images: [Image]
}

struct Image: Decodable {
    let id: String
    let display_sizes: [ImageSize]?
}

struct ImageSize: Decodable {

    let uri: String
}
