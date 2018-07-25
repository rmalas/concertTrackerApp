//
//  Event.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/10/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object, Decodable, Entity {
    @objc dynamic var type: String? = nil
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var displayName: String? = nil
    @objc dynamic var status: String? = nil
    @objc dynamic var id: Int = 0
    @objc dynamic var start: Start? = nil
    @objc dynamic var location: Location? = nil
    let performance = List<Performance>()
    
    static func entityName() -> String {
        return "event"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String,CodingKey {
        case type
        case popularity
        case displayName
        case status
        case id
        case start
        case location
    }
    
}
