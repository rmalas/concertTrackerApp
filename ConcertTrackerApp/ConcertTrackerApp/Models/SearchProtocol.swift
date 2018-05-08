//
//  SearchViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/26/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchViewControllerDelegate: class {
    func searchTextReceived(searchText : String,onTour: String,artID: Int)
}


