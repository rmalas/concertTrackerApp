//
//  Helper.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/8/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class Helper {
    class func clearBackgroundForCell() {
        //https://stackoverflow.com/questions/46477291/ios-11-xcode-9-uitableviewcell-white-background-flickers-on-delete
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
}
