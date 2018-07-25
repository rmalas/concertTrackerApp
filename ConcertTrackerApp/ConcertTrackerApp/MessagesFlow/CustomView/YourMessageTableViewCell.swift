//
//  PartnersTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/10/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class YourMessageTableViewCell: UITableViewCell {
    

    @IBOutlet weak var yourMessageProfileImageView: UIImageView!
    @IBOutlet weak var yourMessageTextView: UITextView!
    @IBOutlet weak var yourMessageTimeStamp: UILabel!    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let linkTextAttributes: [String:Any] = [NSAttributedStringKey.foregroundColor.rawValue:  UIColor.black, NSAttributedStringKey.underlineColor.rawValue: UIColor.white]
        yourMessageTextView.linkTextAttributes = linkTextAttributes
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
