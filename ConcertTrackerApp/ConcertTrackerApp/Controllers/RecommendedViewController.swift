//
//  RecommendedViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class RecommendedViewController: UIViewController {

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var recommendedArtistsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendedArtistsCollectionView.backgroundColor = SetUpColors.whiteColor
    }

}

extension RecommendedViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedArtistCollectionViewCell
        
        return cell
    }
    
    
}
