//
//  CarouselCollectionViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/22/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func prepareForReuse() {
        profileImageView.image = nil
        profileNameLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.containerView.backgroundColor = DesignSetUps.whiteColor
            self.containerView.layer.cornerRadius = 13.0
            self.containerView.layer.shadowColor = UIColor.gray.cgColor
            self.containerView.layer.shadowOpacity = 0.5
            self.containerView.layer.shadowOpacity = 100.0
            self.containerView.layer.shadowOffset = .zero
            self.containerView.layer.shadowPath = UIBezierPath(rect: self.containerView.bounds).cgPath
            self.containerView.layer.shouldRasterize = true
        }
    }

}
