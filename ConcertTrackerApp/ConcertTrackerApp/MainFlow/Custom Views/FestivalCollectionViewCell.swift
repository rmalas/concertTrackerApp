//
//  FestivalCollectionViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/21/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class FestivalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var headlinerImage: UIImageView!
    @IBOutlet weak var headlinerNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func prepareForReuse() {
        headlinerNameLabel.text = nil
        headlinerImage.image = nil
    }
    
}
