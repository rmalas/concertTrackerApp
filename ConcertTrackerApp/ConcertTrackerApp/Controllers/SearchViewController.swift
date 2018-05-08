//
//  SearchViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/7/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var actorsTableView: UITableView!
    @IBOutlet weak var actorsSearchBar: UISearchBar!
    
    weak var searchDelegate: ActorChosenDelegate?
    
    var actorsName = ""
    var actorTourUntil = "Time is not set up yet!"
    var actorsId = 0
    
    var dataArray = [Artist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actorsSearchBar.barStyle = .black
        actorsTableView.backgroundColor = SetUpColors.whiteColor
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "artistProfile", let cell = sender as? UITableViewCell {
            
            let destinationViewController = segue.destination as! ArtistProfileViewController
            destinationViewController.getActor = self
            destinationViewController.favoritesBlock = {(favorite) in
                if favorite {
                   self.dismiss(animated: true, completion: nil)
//                    self.searchDelegate?.searchTextRecieved(artistName: name, artistOnTourUntil: info, artistID: id)
                }
            }
            guard let cellIndexPath = actorsTableView.indexPath(for: cell), let selectedCell = actorsTableView.indexPathForSelectedRow?.row else {
                return
            }
            destinationViewController.artistModel = dataArray[cellIndexPath.row]
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dataArray = []
        actorsTableView.clearsContextBeforeDrawing = true
        try! RequestManager.shared.searchArtist(name: searchBar.text!) { (artist) in
            for item in artist {
                self.dataArray.append(item)
            }
            self.actorsTableView.reloadData()
        }
        searchBar.endEditing(true)
    }
    
}



extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell",for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row].displayName
        cell.backgroundColor = SetUpColors.whiteColor
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.searchDelegate?.searchTextRecieved(artistName: dataArray[indexPath.row].displayName ?? "", artistOnTourUntil: dataArray[indexPath.row].onTourUntil, artistID: dataArray[indexPath.row].id ?? 123)
        //self.dismiss(animated: true, completion: nil)
    }
    
}


protocol ArtistReceivedDelegate: class {
    func getArtist(artistName: String,artistId: Int,artistOnTour: String)
}

extension SearchViewController: ArtistReceivedDelegate {
    func getArtist(artistName: String, artistId: Int, artistOnTour: String) {
        actorsName = artistName
        actorTourUntil = artistOnTour
        actorsId = artistId
    }
}




