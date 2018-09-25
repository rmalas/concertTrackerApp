//
//  ScannerViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/20/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.

//
//hello bfhwejqhbhwecjhbeqwc
//dwebicqchleejecjlr
//jkncwnrcejlrcerwchbwrelcj
//to return

import UIKit

class ScannerViewController: UIViewController {
    
    @IBOutlet weak var scannedMusicTableView: UITableView!
    var music:[Music]? {
        didSet {
            getAllArtistsWhenScanned()
        }
    }
    
    func getAllArtistsWhenScanned() {
        guard let music = music else { return }
        for item in music {
            RequestManager.shared.searchForFirstArtist(name: item.artist) { (artist) in
                guard let firstArtist = artist.first else { return }
                self.artists.append(firstArtist)
            }
        }
    }
    
    var artists = [Artist]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArtistsInfo()
        additionalDesignSetUps()
    }
    
    func additionalDesignSetUps() {
        scannedMusicTableView.backgroundColor = DesignSetUps.whiteColor
    }
    
    func getArtistsInfo() {
        MusicScanerManager.shared.scanLibrary { (music) in
            print(music)
            self.music = music
            DispatchQueue.main.async {
                self.scannedMusicTableView.reloadData()
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showConcertDetailsFromScanner", let cell = sender as? CustomTableViewCell  {
//            let destinationViewController = segue.destination as! ConcertDetailsViewController
//            
//            guard let cellIndexPath = scannedMusicTableView.indexPath(for: cell) else { return }
//            
//            destinationViewController.segueIdentifier == true
//            
//        }
//    }
    
    
    
    
    
}

extension ScannerViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scannedArtistCell", for: indexPath) as! MusicScannerTableViewCell
        let artist = artists[indexPath.row]
        
        if let time = artist.firstConcertDate {
            cell.downTextLabel.text = "First event at \(time)"
        } else {
            try? RequestManager.shared.getUpcommingEvents(artistID: artist.id) { (event) in
                if let firstEventTime = event.first?.start?.date {
                    DispatchQueue.main.async {
                        self.artists[indexPath.row].firstConcertDate = firstEventTime
                            cell.downTextLabel.text = "First event at \(firstEventTime)"
                    }
                }
            }
        }
        
        if let url = artist.artistImageURL {
            SDWebImageManager.shared().loadImage(with: URL(string: url), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
                cell.blurredProfileImageView.image = image
                cell.unblurredProfileImageView.image = image
            })
        } else {
            guard let name = artist.displayName else { return cell }
            RequestManager.shared.getArtistImageURL(name: name) { (url) in
                self.artists[indexPath.row].artistImageURL = url
                SDWebImageManager.shared().loadImage(with: URL(string: url), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
                    cell.blurredProfileImageView.image = image
                    cell.unblurredProfileImageView.image = image
                })
            }
        }
        
        
        
       
        
        cell.topTextLabel.text = artists[indexPath.row].displayName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    
    
}
