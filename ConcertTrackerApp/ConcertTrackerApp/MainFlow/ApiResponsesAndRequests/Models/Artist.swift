//
//  Artist.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/25/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift

protocol ResultsProtocol: Decodable {
    
}

protocol Entity: Decodable {
    static func entityName() -> String
}

extension Array: Entity where Element: Entity {
    static func entityName() -> String {
        return Element.entityName()
    }
}

class SearchPage<E: Entity>: Decodable {
    typealias ResultsType = SearchResults<E>
    var resultsPage: SearchResultPage<ResultsType>? = nil
}

class SearchResultPage<T:ResultsProtocol>: ResultsProtocol, Decodable {
    var status: String? = nil
    var results: T? = nil
    var perPage: Int?
    var page: Int?
    var totalEntries: Int?
}

class SearchResults<T:Entity>: ResultsProtocol, Decodable {
    var info: T?
    
    struct CodingKeys: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        init?(stringValue: String) { self.stringValue = stringValue }
        
        
        static func makeKey(name: String) -> CodingKeys {
            return CodingKeys(stringValue: T.entityName())!
        }
    }
    init() {
        
    }
    convenience init(entities:T) {
        self.init()
        info = entities
    }
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let infoArray:T = try container.decode(T.self, forKey: CodingKeys.makeKey(name: T.entityName()))
        self.init(entities: infoArray)
    }
}

class Artist: Object, Decodable, Entity {
    
    static func entityName() -> String {
        return "artist"
    }
    
    @objc dynamic var displayName: String? = nil
    @objc dynamic var uri: String? = nil
    @objc dynamic var onTourUntil: String? = nil
    @objc dynamic var id: Int = 0
    @objc dynamic var addingDate: Date? = nil
    @objc dynamic var artistImageURL: String? = nil
    @objc dynamic var firstConcertDate: String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    var isFavourite: Bool {
        if self.isInvalidated {
            return false
        }
        let user = DatabaseManager.shared.object(ofType: type(of: self).self, forPrimaryKey: id)
            return user != nil
    }
    
    private var upcomingEvents = List<Event>()
    func getUpcomingEvents(events: @escaping ([Event]) -> Void) {
        if isFavourite || upcomingEvents.count > 0 {
            events(Array(upcomingEvents))
        } else {
            do {
                try RequestManager.shared.getUpcommingEvents(artistID: self.id, completion: { (allEvents) in
                        allEvents.forEach({ (event) in
                            self.upcomingEvents.append(event)
                        })
                    events(allEvents)
                })
                
            } catch {
                events([Event]())
            }
        }
    }
    enum CodingKeys: String, CodingKey {
        case displayName
        case uri
        case onTourUntil
        case id
    }
}

class City: Decodable,Entity {
    static func entityName() -> String {
        return "venue"
    }
    var displayName: String?
    var uri: String?
    var onTourUntil: String?
    var id: Int?
}
