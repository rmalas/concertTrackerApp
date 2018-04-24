//
//  ViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        SearchArtistRequest.shared.fetchDataFromApi()
        
//        let getRequest = GetArtistByNameRequest()
//        getRequest.artistQuery = "Pink Floyd"
//        getRequest.getdata(artistName: "Pink Floyd")
//
//        let getVenueRequest = GetVenueByNameRequest()
//        getVenueRequest.getdata(artistName: "Grammy Awards")
//
        let getVenueCityRequest = GetVenueByCityNameRequest()
        getVenueCityRequest.getdata(artistName: "London")
        
    }
    
    
    
}


