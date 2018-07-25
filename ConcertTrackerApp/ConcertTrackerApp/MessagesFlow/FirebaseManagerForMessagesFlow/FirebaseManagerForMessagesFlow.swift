//
//  FirebaseManagerForMessagesFlow.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/1/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class FirebaseManagerForMessagesFlow {
    static let shared = FirebaseManagerForMessagesFlow()
    
    private init() {  }
    
    func retrieveFreindsList(completion: @escaping (_ friends: [Friend]) -> Void) {
        var friendsList = [Friend]()
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any] {
                var friend = Friend()
                guard let email = dictionary["email"] as? String,let name = dictionary["name"] as? String,let imageUrl = dictionary["profileImageURL"] as? String else { return }
                friend.userID = snapshot.key
                friend.imageURL = imageUrl
                friend.email = email
                friend.name = name
                friendsList.append(friend)
                completion(friendsList)
            }
        }) { (error) in
            print(error)
        }
    }
    
    func getNameFromFireBase(toID: String,text: String,fromID:String,timeStamp: String,completion: @escaping(_ fromUser: Messege) -> Void) {
        let ref = Database.database().reference().child("users").child(toID)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let name = dictionary["name"] as! String
                let imageUrl = dictionary["profileImageURL"] as! String
                let messege = Messege(fromID: fromID, text: text, timeStamp: timeStamp, toID: toID, fromUser: name,profileImageURL: imageUrl)
                completion(messege)
            }
        }
    }
    
    
    
    func observeForCurrentChatroomMessages(partnersID: String,completion: @escaping(_ messagesArray: [Messege]) -> Void) {
        var messagesArray = [Messege]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userReference = Database.database().reference().child("user_messages").child(uid)
        print("USER REFERENCE - ",userReference)
        
        userReference.observe(.childAdded, with: { (snapshot) in
            print("************SNAPSHOT KEY - ",snapshot.key)
            let messageId = snapshot.key
            let messageRef = Database.database().reference().child("messeges").child(messageId)
            print("MESSAGE ID - ",messageId)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                let message = Messege(values: dictionary)
                if message.checkPartnersID() == partnersID {
                    messagesArray.append(message)
                    completion(messagesArray)
                }
                
            })
        }) { (error) in
            print(error)
        }
        
    }
    
    
    
    func observeForUserMessages(completion: @escaping(_ messages: [Messege]) -> Void) {
        var messages = [Messege]()
        var messagesDictionary = [String:Messege]()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("user_messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messageRef = Database.database().reference().child("messeges").child(messageId)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:Any] {
                    guard let toID = dictionary["toID"] as? String, let text = dictionary["text"] as? String,let fromID = dictionary["fromID"] as? String,let timeStamp = dictionary["timeStamp"] as? String else { return }
                    self.getNameFromFireBase(toID: toID, text: text, fromID: fromID, timeStamp: timeStamp, completion: { (message) in
                        if let toid = message.toID,message.toID != Auth.auth().currentUser?.uid {
                            messagesDictionary[toid] = message
                            messages = Array(messagesDictionary.values).sorted(by: { $0.timeStamp! < $1.timeStamp! })
                        }
                        completion(messages)
                    })
                }
                
            }, withCancel: { (error) in
                //MARK: handle error
                print(error)
            })
        }) { (error) in
            //MARK: handle error
            print(error)
        }
    }

    
    
    func observeForMesseges(completion: @escaping(_ messages: [Messege]) -> Void) {
        var messages = [Messege]()
        var messagesDictionary = [String:Messege]()
        let ref = Database.database().reference().child("messeges")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let toID = dictionary["toID"] as? String
                let text = dictionary["text"] as? String
                let fromID = dictionary["fromID"] as? String
                let timeStamp = dictionary["timeStamp"] as? String
                
                self.getNameFromFireBase(toID: toID!, text: text!, fromID: fromID!, timeStamp: timeStamp!, completion: { (message) in
                    if let toid = message.toID {
                        
                        messagesDictionary[toid] = message
                        messages = Array(messagesDictionary.values).sorted(by: { $0.timeStamp! < $1.timeStamp! })
                    }
                    completion(messages)
                })
            }
        }) { (error) in
            print(error)
        }
        
        
    }
    
}
