//
//  Actor.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation


class Actors {
    let name: String
    let onTourUntil: String
    let artistID: Int
    
    init(name: String,onTourUntil: String,artistID: Int) {
        self.name = name
        self.onTourUntil = onTourUntil
        self.artistID = artistID
    }
}
