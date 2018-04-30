//
//  TabBarController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        additionalDesignSetUps()
    }
    
    func additionalDesignSetUps() {
        tabBar.barTintColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)  // bottom TabBar color setUp
        tabBar.tintColor = UIColor(red: 244.0/255, green: 0, blue: 61.0/255, alpha: 1) // bottom tabBar items color setUp
    }
    
}


