//
//  ViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var artistSearchBar: UISearchBar!
    @IBOutlet weak var actorsTableView: UITableView!
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "searchController") as! SearchViewController
        searchVC.searchDelegate = self
        present(searchVC, animated: true, completion: nil)
    }

    var fileterdDataArray: [Actors] = []
    
    var dataArray = DatabaseManager.shared.realm.objects(Actors.self)
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalDesignSetUps()
        setUpFilterBar()
    }
    
    func setUpFilterBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search artist"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        fileterdDataArray = dataArray.filter({( actor : Actors) -> Bool in
            return actor.name.lowercased().contains(searchText.lowercased())
        })
        actorsTableView.reloadData()
    }

    
    
    func additionalDesignSetUps() {
        navigationController?.navigationBar.barTintColor = SetUpColors.whiteColor // navigationBar color setUp
        view.backgroundColor = SetUpColors.whiteColor
        navigationController?.navigationBar.tintColor = SetUpColors.redColor // navigationBarItems color setUp
        
        self.actorsTableView.backgroundColor = SetUpColors.whiteColor

        
        navigationController?.navigationBar.titleTextAttributes = SetUpColors.attributes // Navigation title color setUp with attributes
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArtistDetails", let cell = sender as? CustomTableViewCell {
            let destinationViewController = segue.destination as! ArtistDetailViewController
            
            guard let cellIndexPath = actorsTableView.indexPath(for: cell) else {
                return
            }
            destinationViewController.counter = dataArray[cellIndexPath.row].artistID
        }
    }
}


extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


extension ViewController: SearchViewControllerDelegate {
    func searchTextReceived(searchText: String, onTour: String,artID: Int) {
        
        let contains = dataArray.contains{ $0.name == searchText }
        
        if (!contains){
        let _ = Actors(name: searchText, onTourUntil: onTour,artistID: artID)
            let annimatedAtIndexPath = IndexPath(row: dataArray.count-1, section: 0)
            DispatchQueue.main.async {
                self.actorsTableView.beginUpdates()
                self.actorsTableView.insertRows(at: [annimatedAtIndexPath], with: .automatic)
                self.actorsTableView.endUpdates()
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let printedText = searchBar.text else { return }
        try! RequestManager.shared.searchArtist(name: printedText, completion: {  (artist) in
            guard let searchedValue = artist[0].displayName else { return }
            let searchedOnTour = artist[0].onTourUntil ?? "Already Finished"
            guard let artistID = artist[0].id else { return }
            self.searchTextReceived(searchText: searchedValue,onTour: searchedOnTour,artID: artistID)
        })
        self.actorsTableView.contentOffset.y = searchBar.frame.height
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return fileterdDataArray.count
        }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
        let actor: Actors
        
        if isFiltering() {
            actor = fileterdDataArray[indexPath.row]
        } else {
            actor = dataArray[indexPath.row]
        }
        
        cell.blurredImage.image = UIImage(named: "\(actor.name)") ?? UIImage(named: "Rita Ora")
        cell.unBlurredImage.image = UIImage(named: "\(actor.name)") ?? UIImage(named: "Rita Ora")
        cell.artistConcertPlace.text = "Tour until∙\(String(describing: actor.onTourUntil))"
        cell.artistNameLabel.text = actor.name
        cell.concertDateLabel.text = "Click for more info"
        
        return cell
        
    }
    
}

protocol ActorChosenDelegate: class {
    func searchTextRecieved(artistName: String,artistOnTourUntil: String?,artistID: Int)
}

extension ViewController: ActorChosenDelegate {
    func searchTextRecieved(artistName: String, artistOnTourUntil: String?, artistID id: Int) {
        let actor = Actors(name: artistName, onTourUntil: artistOnTourUntil, artistID: id)
        actor.writeToRealm()
        self.actorsTableView.reloadData()
    }
}





