//
//  Messege.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/3/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Firebase

struct Messege {
    var fromID: String?
    var text: String?
    var timeStamp: String?
    var toID: String?
    var fromUser: String?
    var profileImageURL: String?
    
    
    func checkPartnersID() -> String? {
        return fromID == Auth.auth().currentUser?.uid ? toID : fromID
    }
    
    func ifMessageIsYour() -> Bool {
        return fromID == Auth.auth().currentUser?.uid
    }
    
    func getTime() -> String {
        guard let time = timeStamp else { preconditionFailure() }
        
        let timeToDouble = Double(time)
        
        let stamp = Date(timeIntervalSince1970: timeToDouble!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        
        return dateFormatter.string(from: stamp)
        
    }
    
    func checkIfContaintsDeepLink() -> Bool {
        
        guard let text = self.text else { preconditionFailure() }
        print("message contains deep link",text.contains("ConcertTrackerApp://concert/"))
        return text.contains("ConcertTrackerApp")
    }
    
    
    
    init(fromID:String,text: String,timeStamp: String,toID:String,fromUser: String,profileImageURL:String) {
        self.fromID = fromID
        self.text = text
        self.timeStamp = timeStamp
        self.toID = toID
        self.fromUser = fromUser
        self.profileImageURL = profileImageURL
    }
    
    init(values: [String: Any]) {
        fromID = values["fromID"] as? String
        text = values["text"] as? String
        timeStamp = values["timeStamp"] as? String
        toID = values["toID"] as? String
        fromUser = ""
        profileImageURL = ""
    }
    
}
