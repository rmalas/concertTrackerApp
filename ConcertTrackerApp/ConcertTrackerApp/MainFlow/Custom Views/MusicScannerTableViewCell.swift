//
//  MusicScannerTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/20/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class MusicScannerTableViewCell: UITableViewCell {

    @IBOutlet weak var blurredProfileImageView: UIImageView!
    @IBOutlet weak var unblurredProfileImageView: UIImageView!
    @IBOutlet weak var downTextLabel: UILabel!
    @IBOutlet weak var topTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        blurredProfileImageView.image = nil
        unblurredProfileImageView.image = nil
    }

}
