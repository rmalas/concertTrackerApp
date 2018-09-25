//
//  MessageTableViewCell.swift
//  
//
//  Created by Roman Malasniak on 7/9/18.
//

import UIKit

class PartnersTableViewCell: UITableViewCell {

    @IBOutlet weak var partnersProfileImageView: UIImageView!
    @IBOutlet weak var partnersMessageTextView: UITextView!
    @IBOutlet weak var partnersMessageTimestamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        let linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.black, NSAttributedStringKey.underlineColor.rawValue: UIColor.white]
        partnersMessageTextView.linkTextAttributes = linkTextAttributes
    }
    
    func setConstraintPriorities() {
//        leadingConstraintOfContentView.priority = UILayoutPriority.defaultHigh
//        trailingConstraintOfContentView.priority = UILayoutPriority.defaultHigh
    }
    
    func setMediumConstraintPriority() {
//        leadingConstraintOfContentView.priority = UILayoutPriority.defaultLow
//        trailingConstraintOfContentView.priority = UILayoutPriority.defaultLow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
