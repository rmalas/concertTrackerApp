//
//  RoundedProfileImageView.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/11/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class RoundedProfileImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
    }
    
    

}
