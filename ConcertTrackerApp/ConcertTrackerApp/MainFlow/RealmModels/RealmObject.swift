//
//  Favourites.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    func writeToRealm() {
        do {
            try DatabaseManager.shared.execute { (realm) in
                try realm.write {
                    realm.add(self, update: true)
                }
            }
        }
        catch (let error) {
            print(error)
        }
    }
    
    func deleteFromRealm() {
        do {
            try DatabaseManager.shared.execute({ (realm) in
                try realm.write {
                    realm.delete(self)
                }
            })
        } catch {
            print(123)
        }
    }
}

