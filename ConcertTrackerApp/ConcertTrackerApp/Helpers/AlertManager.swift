//
//  AlertManager.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/10/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ConcertTrackerAlertController: UIAlertController {
    
    convenience init(title: String,message: String) {
        self.init(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        self.addAction(action)
    }
    
}
