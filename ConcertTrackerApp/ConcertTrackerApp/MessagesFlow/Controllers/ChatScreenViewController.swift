 //
//  ChatScreenViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/3/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import Firebase
 

class ChatScreenViewController: UIViewController {
    
    var concertUrl = ""
    
    //MARK: actions
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        guard let text = textfield.text else { return }
        guard let id = partnersID else { return }
        if text.isEmpty {
            return
        } else {
            SendMessegeManager.shared.sendMessege(messege: text, userID: id)
            textfield.text?.removeAll()
            view.endEditing(true)
            self.messegesTableView.reloadData()
            scrollToBottom()
        }
    }
    
    @IBAction func tapToHideKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK:Outlets
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var messegesTableView: UITableView!
    
    
    var friend = Friend()
    var messages = [Messege]()
    var partnersID: String?
    var you = Friend()
    
    func checkIfShareConcert() {
        if concertUrl.contains("ConcertTrackerApp") {
            textfield.text = concertUrl
        }
        else {
            textfield.text = ""
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfShareConcert()
        getChatUserData()
        
        
        textfield.keyboardAppearance = .dark
        addObservers()

        FirebaseManagerForMessagesFlow.shared.observeForCurrentChatroomMessages(partnersID: partnersID!) { (messages) in
            self.messages = messages
            DispatchQueue.main.async {
                self.messegesTableView.reloadData()
                self.scrollToBottom()
            }
        }
    }
    
    func getChatUserData() {
        getPartnersData(partnersID: partnersID!) { (friend) in
            DispatchQueue.main.async {
                self.title = friend.name
                print(friend)
                self.friend = friend
            }
        }
        
        getPartnersData(partnersID: (Auth.auth().currentUser?.uid)!) { (user) in
            self.you = user
        }
    }
    
    func getPartnersData(partnersID id: String,completion: @escaping (_ friend :Friend) -> Void) {
        let ref = Database.database().reference().child("users").child(id)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let userName = dictionary["name"] as! String
            let email = dictionary["email"] as! String
             let profileImageUrl = dictionary["profileImageURL"] as! String
            print(userName)
            print("*******************")
            
            let chatPartner = Friend(name: userName, email: email, imageURL: profileImageUrl, userID: snapshot.key)
            completion(chatPartner)
        }
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(ChatScreenViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatScreenViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            if self.messages.count > 1 {
                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                if indexPath.row < self.messegesTableView.numberOfRows(inSection: 0) {
                    self.messegesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height-50
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height-50
            }
        }
    }
}


extension ChatScreenViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let identifier: String
        
        let imageUrl: String
        
        if message.ifMessageIsYour() {
            
            
            
           identifier = "yourMessageCell"
            imageUrl = you.imageURL
        } else {
            identifier = "partnersMessageCell"
            imageUrl = friend.imageURL
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PartnersTableViewCell
        cell.partnersMessageTextView.text = message.text
        cell.partnersMessageTimestamp.text = message.getTime()
        
        SDWebImageManager.shared().loadImage(with: URL(string: imageUrl), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
            DispatchQueue.main.async {
                cell.partnersProfileImageView.image = image
            }
        })
        return cell
    }
    
    
}



























