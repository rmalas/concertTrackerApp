//
//  FirebaseUserRegister.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/1/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase
import UIKit

class FirebaseManager {
    
    struct FirebaseConstants {
        static let firebaseReference = "https://concerttrackerapp.firebaseio.com/"
    }
    
    static let shared = FirebaseManager()
    
    private init() {  }
    
    func registerUser(name userName: String,password userPassword: String,email userEmail: String,image profileImage: UIImage,completion: @escaping (_ registered: Bool) -> Void) {
        var registered = false
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (userResult, error) in
            if error != nil {
                completion(registered)
            }
            
            guard let uid = userResult?.user.uid else {
                completion(registered);
                return
            }
            
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        completion(registered)
                    }
                    
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            completion(registered)
                            print(error)
                        }
                        
                        guard let downloadURL = url else { return }
                        
                        let values = ["name":userName,"email":userEmail,"profileImageURL":downloadURL.absoluteString]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        registered = true
                        completion(registered)
                    })
                })
            }
        }
    }
    
    func registerUserIntoDatabaseWithUID(uid: String,values:[String: AnyObject]) {
        let ref = Database.database().reference(fromURL: FirebaseConstants.firebaseReference)
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
            }
            print("succesfully saved!")
        })
    }
    
    
    
    func handleLogin(password userPassword: String,email userEmail: String,completion: @escaping (_ granted: Bool) -> Void) {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { (user, error) in
            var permissionGranted = false
            if error != nil {
                completion(permissionGranted)
            } else {
                permissionGranted = true
                completion(permissionGranted)
            }
            
        }
    }
    
    
}
