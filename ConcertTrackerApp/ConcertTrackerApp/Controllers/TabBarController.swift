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
        tabBar.barTintColor = SetUpColors.whiteColor // bottom TabBar color setUp
        tabBar.tintColor = SetUpColors.redColor // bottom tabBar items color setUp
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


