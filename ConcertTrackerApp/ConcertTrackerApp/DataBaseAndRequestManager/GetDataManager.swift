//
//  File.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class FetchDataManager {
    
    static let shared = FetchDataManager()
    
    private let requestManager = RequestManager()
    
    private init() {}
    
    func getData(artistModel artist: Artist, completion: @escaping (([Event]) -> Void)) {
        if Reachability.isConnectedToNetwork() {
            try! requestManager.getUpcommingEvents(artistID: artist.id, completion: { (event) in
                completion(event)
            })
        } else if artist.isFavourite {
         // DB
        }
    }
    
    func getDataFromRealm() {
        
    }
    
}
