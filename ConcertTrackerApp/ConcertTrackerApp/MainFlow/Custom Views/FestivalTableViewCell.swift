//
//  FestivalTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/21/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class FestivalTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var headlinerNameLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = DesignSetUps.greyColor
    }

}
