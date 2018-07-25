//
//  MusicScanerManager.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicScanerManager {
    static let shared = MusicScanerManager()
    
    private init() { }
    
    
    func scanLibrary(completion: @escaping(_ music: [Music]) -> Void) {
        var musicArray = [Music]()
        
        let query = MPMediaQuery.songs()
        if let items = query.items {
            for item in items {
                guard let artist = item.artist else { return }
                let song = Music(artist: artist)
                
                if musicArray.filter({$0.artist == song.artist}).isEmpty {
                    musicArray.append(song)
                }
            }
        }
        completion(musicArray)
    }
}
