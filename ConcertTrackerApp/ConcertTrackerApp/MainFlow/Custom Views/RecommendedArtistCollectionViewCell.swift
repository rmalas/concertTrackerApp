//
//  RecommendedArtistCollectionViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/24/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class RecommendedArtistCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var recommendedArtistImage: UIImageView!
    
    @IBOutlet weak var RecommendedArtistNameLabel: UILabel!
    
    override func prepareForReuse() {
        recommendedArtistImage.image = nil
        RecommendedArtistNameLabel.text = nil
    }
    
    override func awakeFromNib() {
        backgroundView?.backgroundColor = DesignSetUps.greyColor
        layer.cornerRadius = 10
        RecommendedArtistNameLabel.textColor = DesignSetUps.whiteColor
    }
    
}
