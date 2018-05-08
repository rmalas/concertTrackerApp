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
    var realm: Realm!
    
    
    func execute(_ completion: (_ realmObject: Realm) throws -> Void) throws {
        try completion(realm)
    }

    private func configuraRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    private init() {
        configuraRealm()
        realm = try! Realm()
        print(realm.configuration.fileURL)
    }
}
