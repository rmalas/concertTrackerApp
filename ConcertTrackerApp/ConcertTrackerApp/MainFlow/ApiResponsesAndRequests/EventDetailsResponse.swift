//
//  EventDetailsResponse.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/1/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import RealmSwift


class Performance:Object,Decodable {
    @objc dynamic var displayName: String? = nil
}

class Start: Object,Decodable {
    @objc dynamic var time: String? = nil
    @objc dynamic var date: String? = nil
}
