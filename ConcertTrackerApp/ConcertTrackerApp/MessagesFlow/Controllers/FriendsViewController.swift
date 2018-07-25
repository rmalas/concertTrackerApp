//
//  FriendsViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/1/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var freindsTableView: UITableView!
    
    var friendsList = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManagerForMessagesFlow.shared.retrieveFreindsList { (friendsList) in
            print("*************")
            print(friendsList)
            self.friendsList = friendsList
            DispatchQueue.main.async {
                self.freindsTableView.reloadData()
            }
        }
        additionalDesignSetUps()
        print(friendsList)
    }
    
    func additionalDesignSetUps() {
        freindsTableView.backgroundColor = DesignSetUps.greyColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChatScreen", let cell = sender as? FriendsTableViewCell {
            let destinationViewController = segue.destination as! ChatScreenViewController
            
            guard let cellIndexPath = freindsTableView.indexPath(for: cell) else {
                return
            }
            //let artistObj = artist(forIndexPath: cellIndexPath)
            
            destinationViewController.friend = friendsList[cellIndexPath.row]
            destinationViewController.partnersID = friendsList[cellIndexPath.row].userID
        }
    }
}


extension FriendsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendsTableViewCell
        
        cell.freindNameLabel.text = friendsList[indexPath.row].name
        cell.friendEmailLabel.text = friendsList[indexPath.row].email
        if let image = SDImageCache.shared().imageFromDiskCache(forKey: friendsList[indexPath.row].imageURL) {
            print("Getting from cache")
            DispatchQueue.main.async {
                cell.profileImageView.image = image
                cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width/2
                cell.profileImageView.clipsToBounds = true
            }
        } else {
            print("loading data from server")
            SDWebImageManager.shared().loadImage(with: URL(string: friendsList[indexPath.row].imageURL), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
                cell.profileImageView.image = image
                cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width/2
                cell.profileImageView.clipsToBounds = true
                SDWebImageManager.shared().saveImage(toCache: image, for: URL(string: self.friendsList[indexPath.row].imageURL))
            })
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    
}
