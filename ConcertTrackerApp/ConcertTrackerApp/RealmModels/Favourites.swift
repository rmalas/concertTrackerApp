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
    @objc dynamic var someVar: String? = nil
}

extension Favourites {
    func writeToRealm(my favourites: Favourites) {
        try! realm?.write {
            realm?.add(favourites)
            print("Saved to realm db")
        }
    }
}

