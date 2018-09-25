//
//  DefaultsSaver.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 8/15/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class DefaultsSaver {
    
    struct Constants {
        static let userDefaultsKey = "CityNames"
        static let userIsLoggedIn = "userIsLoggedIn"
    }
    
    static let shared = DefaultsSaver()
    
    private init() { }
    
    func saveToDefaults(city name: [String]) {
        UserDefaults.standard.set(name, forKey: Constants.userDefaultsKey)
        print("saved")
    }
    
    func setTrueToLogInStatus() {
        UserDefaults.standard.set(true, forKey: Constants.userIsLoggedIn)
    }
    
    func getLoggedInStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.userIsLoggedIn)
    }
    
    func retrieveFromDefaults() -> [String] {
        if let upcommingArray = UserDefaults.standard.array(forKey: Constants.userDefaultsKey)  {
            print("returned some data")
            return upcommingArray as! [String]
        } else {
            print("returned empty array")
            return [String]()
        }
        
    }
}
