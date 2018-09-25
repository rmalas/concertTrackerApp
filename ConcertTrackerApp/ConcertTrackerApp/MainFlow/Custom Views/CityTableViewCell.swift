//
//  CityTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 8/2/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = DesignSetUps.greyColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
