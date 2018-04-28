//
//  ArtistDetailViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    var counter:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        RequestManager.shared.getUpcommingEvents(artistID: counter!)
    }
    
    func setUpDesign() {
        view.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
    }
}
