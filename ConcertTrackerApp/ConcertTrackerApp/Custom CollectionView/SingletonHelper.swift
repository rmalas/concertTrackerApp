//
//  SingletonHelper.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class Helper {
    static let shared = Helper()
    
    private init() {  }
    
    var someArtistsArray = [AnyObject]()
    var VenyeDetailsArray = [AnyObject]()
}
