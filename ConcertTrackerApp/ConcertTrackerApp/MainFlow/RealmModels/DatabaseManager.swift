//
//  DatabaseManager.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/26/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    func execute(_ completion: (_ realmObject: Realm) throws -> Void) throws {
        try completion(Realm())
    }
    
    func save(object: Object) throws {
        try DatabaseManager.shared.execute { (realm) in
            try realm.write {
                realm.add(object, update: true)
            }
        }
    }
    
    func delete(object: Object) throws {
        try DatabaseManager.shared.execute { (realm) in
            try realm.write {
                realm.delete(object)
            }
        }
    }
    
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element> {
        return try! Realm().objects(type)
    }
    
    func object<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element? {
        return try! Realm().object(ofType: type, forPrimaryKey: key)
    }
    
    private func configuraRealm() {
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    private init() {
        configuraRealm()
        print(try! Realm().configuration.fileURL)

    }
    
    func dbUrl() -> URL {
        return Realm.Configuration.defaultConfiguration.fileURL!
    }
}
