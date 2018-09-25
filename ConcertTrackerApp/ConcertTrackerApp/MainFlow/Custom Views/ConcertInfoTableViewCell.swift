//
//  ConcertInfoTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 8/2/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ConcertInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var ArtistLabel: UILabel!
    @IBOutlet weak var concertInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
