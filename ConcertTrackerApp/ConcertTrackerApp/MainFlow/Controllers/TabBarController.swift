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
        
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                let _ = viewController.view
            }
        }
    }
    
    func additionalDesignSetUps() {
        tabBar.barTintColor = DesignSetUps.whiteColor // bottom TabBar color setUp
        tabBar.tintColor = DesignSetUps.redColor // bottom tabBar items color setUp
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


