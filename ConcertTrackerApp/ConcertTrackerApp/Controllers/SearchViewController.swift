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

class SearchViewController: UIViewController,UISearchBarDelegate {
    
    weak var searchDelegate: SearchViewControllerDelegate?
    
    var searchedValue: String?
    var onTourUntil: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        

        
        guard let printedText = searchBar.text else { return }
        try! RequestManager.shared.searchArtist(name: printedText) { (artist) in
            guard let searchedValue = artist[0].displayName else { return }
            let searchedOnTour = artist[0].onTourUntil ?? "Already Finished"
            guard let artistID = artist[0].id else { return }
            self.searchDelegate?.searchTextReceived(searchText: searchedValue,onTour: searchedOnTour,artID: artistID)
        }
        
        dismiss(animated: true, completion: nil)
    }

    
}
