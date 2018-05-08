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
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func additionalSetUps() {
//        detailsBackgroundView.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
    }
    
    @IBOutlet weak var detailsBackgroundView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistConcertInfoLabel: UILabel!
    
}
