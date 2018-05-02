//
//  ConcertDetailsTableViewCell.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/2/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import MapKit

class ConcertDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backViewTwo: UIView!
    @IBOutlet weak var additionalInfoLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var concertStartTime: UILabel!
    @IBOutlet weak var ticketsPrice: UILabel!
    @IBOutlet weak var ticketButton: UIButton!
    
    @IBAction func visitButtonClicked(_ sender: UIButton) {
        print(123)
    }
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCell.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.masksToBounds = true
        
        concertStartTime.textColor = UIColor.white
        ticketsPrice.textColor = UIColor.white
        nameLbl.textColor = UIColor.white
        additionalInfoLbl.textColor = UIColor.white
        infoLbl.textColor = UIColor.white
        backView.backgroundColor = UIColor(red: 83/255.0, green: 84/255.0, blue: 88/255, alpha: 1)
        backViewTwo.backgroundColor = UIColor(red: 83/255.0, green: 84/255.0, blue: 88/255, alpha: 1)
        ticketButton.backgroundColor = UIColor(red: 227/255.0, green: 49/255.0, blue: 75/255, alpha: 1)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
