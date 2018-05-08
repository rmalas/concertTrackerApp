//
//  Actor.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift

class Actors: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var onTourUntil: String = ""
    @objc dynamic var artistID: Int = 0
    
    
    override class func primaryKey() -> String? {
        return "artistID"
    }
    
}

extension Actors {
    convenience init(name: String,onTourUntil: String?,artistID: Int) {
        self.init()
        self.name = name
        self.onTourUntil = onTourUntil ?? "Already finished"
        self.artistID = artistID
    }
}


















