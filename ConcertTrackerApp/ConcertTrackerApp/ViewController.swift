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
        
        try! RequestManager.shared.searchArtist(name: "Ed Sheeran") { (artist) in
            for item in artist {
                print(item.displayName ?? "no item parsed",item.displayName)
            }
        }
//
          //try! RequestManager.shared.getDataWithCityName(name: "London")
//
//        RequestManager.shared.getDataWithVenueName(name: "Grammy Awards")  { (artist) in
//        }
        
    }
    
    
    
}


