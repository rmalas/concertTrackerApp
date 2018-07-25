//
//  LoggedInChecker.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class LoggedInChecker {
    
    struct UserDefaultsConstants {
        static let key = "logged"
    }
    
    static let shared = LoggedInChecker()
    
    private init() { }
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsConstants.key)
    }
    
    func setTrueToChecker() {
        UserDefaults.standard.set(true, forKey: UserDefaultsConstants.key)
    }
    
    func setFalseToChecker() {
        UserDefaults.standard.set(false, forKey: UserDefaultsConstants.key)
    }
    
    func showScreen() {
        print(123)
    }
    
}
