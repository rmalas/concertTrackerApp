//
//  MessagesViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/1/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomsViewController: UIViewController {
    
    var messages = [Messege]()
    
    var concertId = 0
    
    
    @IBOutlet weak var chatRoomsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(concertId)
        FirebaseManagerForMessagesFlow.shared.observeForUserMessages { (messages) in
            self.messages = messages
            DispatchQueue.main.async {
                self.chatRoomsTableView.reloadData()
            }
        }
        designSetUps()
        title = "Messenger"
        navigationController?.navigationBar.titleTextAttributes = DesignSetUps.attributes
    }

    func designSetUps() {
        self.navigationController?.navigationBar.barTintColor = DesignSetUps.greyColor
        self.navigationController?.navigationBar.tintColor = DesignSetUps.redColor
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        if segue.identifier == "showChatView" {
            let destinationViewController = segue.destination as! ChatScreenViewController
            
            guard let cellIndexPath = chatRoomsTableView.indexPathForSelectedRow else {
                return
            }
             let message = messages[cellIndexPath.row]
            guard let partnersID  = message.checkPartnersID() else { return }
            destinationViewController.partnersID = partnersID
            if concertId != 0 {
                destinationViewController.concertUrl = "ConcertTrackerApp://concert/\(concertId)"
            }
        }
    }
    
    
    
}


extension ChatRoomsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatRoom", for: indexPath) as! ChatRoomTableViewCell
        let message = messages[indexPath.row]
        
        
        if let image = SDImageCache.shared().imageFromDiskCache(forKey: message.profileImageURL) {
            print("Getting from cache")
            DispatchQueue.main.async {
                cell.profileImage.image = image
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.width/2
                cell.profileImage.clipsToBounds = true
            }
        } else {
            print("loading data from server")
            SDWebImageManager.shared().loadImage(with: URL(string: message.profileImageURL!), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
                cell.profileImage.image = image
                cell.profileImage.layer.cornerRadius = cell.profileImage.frame.width/2
                cell.profileImage.clipsToBounds = true
                SDWebImageManager.shared().saveImage(toCache: image, for: URL(string: message.profileImageURL!))
            })
        }
        guard let secs = message.timeStamp else { return cell }
        
        if let doubleSecs = Double(secs) {
            let timeStamp = NSDate(timeIntervalSince1970: doubleSecs)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            cell.timeStampLabel.text = dateFormatter.string(for: timeStamp)
        }
        
        cell.friendsNameLabel.text = message.fromUser
        cell.messageLabel.text = message.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    
}
