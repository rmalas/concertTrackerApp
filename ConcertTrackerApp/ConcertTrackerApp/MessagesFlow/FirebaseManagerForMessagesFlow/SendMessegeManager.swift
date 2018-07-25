//
//  SendMessegeManager.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/3/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Firebase

class SendMessegeManager {
    
    static let shared = SendMessegeManager()
    
    private init() {  }
    
    func sendMessege(messege upcommingMessege: String,userID id: String) {
        let ref = Database.database().reference().child("messeges")
        let fromID = Auth.auth().currentUser?.uid
        let time = Int(NSDate().timeIntervalSince1970)
        let timeStamp = NSNumber(integerLiteral: time)
        let childRef = ref.childByAutoId()
        let values = ["text" : upcommingMessege, "toID" : id, "fromID":fromID, "timeStamp" : "\(timeStamp)"]
//        childRef.updateChildValues(values)
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                //MARK: handle error
                return
            }
            
            guard let fromUserId = fromID else { return }
            let userMessagesRef = Database.database().reference().child("user_messages").child(fromUserId)
            let messageID = childRef.key
            userMessagesRef.updateChildValues([messageID:1])
            
            let recipientMessageRef = Database.database().reference().child("user_messages").child(id)
            recipientMessageRef.updateChildValues([messageID:1])
            
        }
    }
    
    
}


/*
 
 let ref = Database.database().reference().child("messeges")
 let toID = friend.userID
 let fromID = Auth.auth().currentUser?.uid
 let childRef = ref.childByAutoId()
 let values = ["text" : messege, "toID" : toID, "fromID":fromID]
 childRef.updateChildValues(values)
 
 
 */
