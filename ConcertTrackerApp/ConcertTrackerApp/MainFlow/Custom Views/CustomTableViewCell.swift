//
//  CustomTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/26/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func prepareForReuse() {
        unBlurredImage.image = nil
        blurredImage.image = nil
        concertDateLabel.text = nil
        artistNameLabel.text = nil
        artistConcertPlace.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var unBlurredImage: UIImageView!
    @IBOutlet weak var blurredImage: UIImageView!
    @IBOutlet weak var concertDateLabel: UILabel!
    @IBOutlet weak var artistConcertPlace: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
}
