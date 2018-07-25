//
//  RecommendedViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class RecommendedViewController: UIViewController {
    
    var artists = DatabaseManager.shared.objects(Artist.self)
    
    var recommendedArtists: [Artist] = []
    
    var recommendedNames: [String] = []
    
    
    
    //@IBOutlet weak var recommendedCollectionView: UICollectionView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var recommendedArtistsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
         uiSetUps()
        if artists.count > 0 {
            getRecommended()
            
        }
    }
    
    func getRecommended() {
        RequestManager.shared.getRecommendedArtists(artistArray: Array(artists)) { (artist) in
            self.recommendedArtists = artist
            DispatchQueue.main.async {
             self.recommendedArtistsCollectionView.reloadData()
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArtistProfile", let cell = sender as? RecommendedArtistCollectionViewCell {
            let destinationViewController = segue.destination as! ArtistProfileViewController

            guard let cellIndexPath = recommendedArtistsCollectionView.indexPath(for: cell) else {
                return
            }
            destinationViewController.artistModel = recommendedArtists[cellIndexPath.row]
        }
    }
    
    //MARK: UISetUps
    func uiSetUps() {
        navigationController?.navigationBar.barTintColor = DesignSetUps.whiteColor
        title = "Recommendations"
        navigationController?.navigationBar.titleTextAttributes = DesignSetUps.attributes
        navigationController?.navigationBar.tintColor = DesignSetUps.redColor
        recommendedArtistsCollectionView.backgroundColor = DesignSetUps.whiteColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension RecommendedViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedArtists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedArtistCollectionViewCell
        
        guard let name = recommendedArtists[indexPath.row].displayName else {
            return cell
        }
        cell.RecommendedArtistNameLabel.text = name
        
        if let imageUrl = recommendedArtists[indexPath.row].artistImageURL {
            SDWebImageManager.shared().loadImage(with: URL(string: imageUrl), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
                DispatchQueue.main.async {
                    cell.recommendedArtistImage.image = image
                }
            })
        } else {
            cell.recommendedArtistImage.image = UIImage(named: "Rita Ora")
        }
        
        return cell
    }
    
        
}
