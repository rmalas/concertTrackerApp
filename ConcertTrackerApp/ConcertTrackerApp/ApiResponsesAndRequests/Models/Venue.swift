//
//  Venue.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/22/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift

class Venue: Object, Decodable,Entity {
    
    static func entityName() -> String {
        return "event"
    }
    @objc dynamic var displayName: String? = nil
    
}
