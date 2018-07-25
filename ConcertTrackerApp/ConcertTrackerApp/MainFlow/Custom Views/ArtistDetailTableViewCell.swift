//
//  ArtistDetailTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/30/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ArtistDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        additionalSetUps()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func additionalSetUps() {
    }
    
    @IBOutlet weak var detailsBackgroundView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistConcertInfoLabel: UILabel!
    
}
