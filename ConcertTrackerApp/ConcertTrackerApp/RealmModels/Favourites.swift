//
//  Favourites.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift

class Favourites: Object {
    @objc dynamic var name: String? = nil
    @objc dynamic var id: String? = nil
}



extension Favourites {
    func writeToRealm() {
        
        do {
            try DatabaseManager.shared.execute { (realm) in
                try realm.write {
                    realm.add(self)
                }
            }
        }
        catch (let error) {
            print(error)
        }
    }
}

