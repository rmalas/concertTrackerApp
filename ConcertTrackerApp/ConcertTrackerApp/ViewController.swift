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
        
        try! RequestManager.shared.searchArtist(name: "Pink Floyd") { (artist) in
            print()
        }
        
        try! RequestManager.shared.getDataWithCityName(name: "London")
        
        RequestManager.shared.getDataWithVenueName(name: "Grammy Awards")  { (artist) in
        }
        
    }
    
    
    
}


