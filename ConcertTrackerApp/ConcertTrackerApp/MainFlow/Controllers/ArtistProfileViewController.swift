//
//  ArtistProfileViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/8/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import RealmSwift

class ArtistProfileViewController: UIViewController {
    
    var artistModel: Artist!
    var favoritesBlock: ((_ addedToFavorites: Bool) -> Void)?
    var events = [Event]()
    
    
    @IBOutlet weak var conertTableView: UITableView!
    @IBOutlet weak var artistProfileImage: UIImageView!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToFavouritesButtonClicked(_ sender: UIButton) {
        do {
            if artistModel.isFavourite {
                try DatabaseManager.shared.delete(object: artistModel)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                artistModel.addingDate = Date()
                try DatabaseManager.shared.save(object: artistModel)
            }
            updateFavoritesButton()
        } catch (let error) {
            let alertCtrl = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertCtrl.addAction(okAction)
            self.present(alertCtrl, animated: true, completion: nil)
        }
    }
    
    func setUpProfileImage() {
        
        if let image = SDImageCache.shared().imageFromDiskCache(forKey: artistModel.artistImageURL) {
            print("Getting from cache")
            DispatchQueue.main.async {
                self.artistProfileImage.image = image
            }
        } else {
            RequestManager.shared.getArtistImageURL(name: artistModel.displayName!) { (artistImageURL) in
                SDWebImageManager.shared().loadImage(with: URL(string: (artistImageURL)), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
                    DispatchQueue.main.async {
                        self.artistProfileImage.image = image
                    }
                    SDWebImageManager.shared().saveImage(toCache: image, for: URL(string: (artistImageURL)))
                })
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !artistModel.isFavourite {
            RequestManager.shared.getArtistImageURL(name: artistModel.displayName!) { (artistURL) in
                DispatchQueue.main.async {
                    self.artistModel.artistImageURL = artistURL
                }
            }
        }
        self.navigationItem.rightBarButtonItem = self.addButton
        setUpProfileImage()
        title = artistModel.displayName!
        additionalSetUps()
        artistModel.getUpcomingEvents { (events) in
            self.events = events
            DispatchQueue.main.async {
                self.conertTableView.reloadData()
            }
        }
    }
    
    
    
    lazy var addButton: UIBarButtonItem = {
        return  UIBarButtonItem(title: "Map", style: .done, target: self, action: #selector(addTapped))
    }()
    
    
    @objc func addTapped() {
        print("showing map")
        let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.upcommingEvents = events
        print("showing map")
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func additionalSetUps() {
        conertTableView.backgroundColor = DesignSetUps.greyColor
        artistProfileImage.layer.cornerRadius = 15
        artistProfileImage.layer.masksToBounds = true
        view.backgroundColor = DesignSetUps.whiteColor
        addToFavouritesButton.backgroundColor = DesignSetUps.redColor
        addToFavouritesButton.layer.cornerRadius = 5
        addToFavouritesButton.layer.masksToBounds = true
        
        updateFavoritesButton()
    }
    
    func updateFavoritesButton() {
        //favouriteButton state
        if artistModel.isFavourite {
            addToFavouritesButton.setTitle("Remove from favourites", for: .normal)
        } else {
            addToFavouritesButton.setTitle("Track artist", for: .normal)
        }
    }
    
}


extension ArtistProfileViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.isEmpty ? 1 : events.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if events.isEmpty == true {
            let noEventsCell = tableView.dequeueReusableCell(withIdentifier: "detailCell",for: indexPath) as! ArtistDetailTableViewCell
            noEventsCell.artistNameLabel.text = "No events for this artist. Come back soon!"
            noEventsCell.isUserInteractionEnabled = false
            return noEventsCell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell",for: indexPath) as! ArtistDetailTableViewCell
            
            let event = events[indexPath.row]
            cell.artistNameLabel.text = event.displayName
            
            guard let startDate = event.start?.date, let startTime = event.start?.time else { return cell }
            cell.artistConcertInfoLabel.text = ("Time:\(startDate), at \(startTime)")
            cell.isUserInteractionEnabled = true
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "ConcertDetailsViewController") as? ConcertDetailsViewController {
            secondVC.upcommingName = artistModel?.displayName ?? "Rita Ora"
            artistModel.getUpcomingEvents { (events) in
                secondVC.upCommingID = events[indexPath.row].id
            }
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
}
