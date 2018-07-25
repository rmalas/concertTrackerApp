//
//  GetArtistPictureRequest.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/4/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class GetArtistImageURLRequest: GettyImagesAbstractRequest {
    var artistName: String?
    
    override var url: String {
        guard let name = artistName else { return "" }
        return "images?phrase=\(name)&fields=preview"
    }
    
    
}
