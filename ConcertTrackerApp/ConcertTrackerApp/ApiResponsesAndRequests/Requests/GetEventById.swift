//
//  Requests.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/26/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetEventByIdRequest : AbstractRequest {
    var artistQuery: String?
    
    override var url: String {
        return "search/events/"
    }
}

