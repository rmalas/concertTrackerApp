//
//  PreviewTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/12/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var previewTextView: UITextView!
    @IBOutlet weak var previewImageView: RoundedProfileImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
