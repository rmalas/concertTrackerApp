//
//  RecommendedArtistCollectionViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class RecommendedArtistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundViewForRecommendedCell: UIView!
    
    @IBOutlet weak var recommendedArtistNameLabel: UILabel!
    
    override func awakeFromNib() {
        backgroundViewForRecommendedCell.backgroundColor = SetUpColors.greyColor
        recommendedArtistNameLabel.text = "Rita Ora"
    }
    
}
