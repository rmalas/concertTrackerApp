//
//  MessageTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 7/4/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {
    @IBOutlet weak var friendsNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = DesignSetUps.whiteColor
        // Initialization code
    }

   
}
