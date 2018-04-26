//
//  Artist.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/25/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
protocol ResultsProtocol: Decodable {
    
}

protocol Entity: Decodable {
    static func entityName() -> String
}

class SearchPage<E: Entity>: Decodable {
    typealias ResultsType = Results<E>
    var resultsPage: SearchResultPage<ResultsType>? = nil
}

class SearchResultPage<T:ResultsProtocol>: ResultsProtocol, Decodable {
    var status: String? = nil
    var results: T? = nil
    var perPage: Int = 0
    var page: Int = 0
    var totalEntries: Int = 0
}

class Results<T:Entity>: ResultsProtocol, Decodable {
    var info: [T]?
    
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
    convenience init(entities:[T]) {
        self.init()
        info = entities
    }
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let infoArray:[T] = try container.decode([T].self, forKey: CodingKeys.makeKey(name: T.entityName()))
        self.init(entities: infoArray)
    }
}


class Artist: Decodable, Entity {
    static func entityName() -> String {
        return "artist"
    }
    
    var displayName: String?
    //var identifier: SearchArtist_Lists?
    var uri: String?
    var onTourUntil: String?
    var id: Int?
    
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
