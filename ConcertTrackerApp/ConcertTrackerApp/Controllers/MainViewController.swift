//
//  ViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    var notificationToken: NotificationToken? = nil
    
    @IBOutlet weak var artistSearchBar: UISearchBar!
    @IBOutlet weak var actorsTableView: UITableView!
    
    
    var fileterdDataArray: [Artist] = []
    
    var shouldScrollToBottom = false
    
    var artists = DatabaseManager.shared.objects(Artist.self)
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalDesignSetUps()
        setUpFilterBar()
        initNotificationToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.actorsTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        if shouldScrollToBottom {
            self.scrollToBottom()
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func initNotificationToken() {
        notificationToken = artists.observe { [weak self] (changes: RealmCollectionChange) in
            guard let `self` = self else { return }
            switch changes {
            case .initial:
                break
            case .update(_, _, let insertions, _):
                if insertions.count > 0 {
                    self.shouldScrollToBottom = true
                }
                self.actorsTableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    
   
    
    
    // MARK: Filtering
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        fileterdDataArray = artists.filter ({( artist : Artist) -> Bool in
            guard let artistName = artist.displayName else {
                return false
            }
            return artistName.lowercased().contains(searchText.lowercased())
        })
        actorsTableView.reloadData()
    }
    
    // MARK: UI Setup
    func scrollToBottom() {
        let numberOfRows = actorsTableView.numberOfRows(inSection: 0)
        let path = IndexPath(row: numberOfRows - 1, section: 0)
        if numberOfRows > 0 {
            self.actorsTableView.scrollToRow(at: path, at: .bottom, animated: true)
        }
    }
    
    func deleteFromTableView(index: IndexPath) {
        let artistObj = artist(forIndexPath: index)
       try! DatabaseManager.shared.delete(object: artistObj!)
        self.actorsTableView.beginUpdates()
        self.actorsTableView.deleteRows(at: [index],with: .automatic)
        self.actorsTableView.endUpdates()
    }
    
    
    func setUpFilterBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search artist"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func additionalDesignSetUps() {
        searchController.searchBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = SetUpColors.whiteColor // navigationBar color setUp
        view.backgroundColor = SetUpColors.whiteColor
        navigationController?.navigationBar.tintColor = SetUpColors.redColor // navigationBarItems color setUp
        
        self.actorsTableView.backgroundColor = SetUpColors.whiteColor
        
        navigationController?.navigationBar.titleTextAttributes = SetUpColors.attributes // Navigation title color setUp with attributes
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArtistDetails", let cell = sender as? CustomTableViewCell {
            let destinationViewController = segue.destination as! ArtistProfileViewController
            
            guard let cellIndexPath = actorsTableView.indexPath(for: cell) else {
                return
            }
            //let artistObj = artist(forIndexPath: cellIndexPath)
            destinationViewController.artistModel = artist(forIndexPath: cellIndexPath)
        }
    }
}


extension MainViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            deleteFromTableView(index: indexPath)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return fileterdDataArray.count
        }
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundView = UIView()
        
        cell.backgroundView?.backgroundColor = UIColor.clear
    }
    
    func artist(forIndexPath indexPath: IndexPath) -> Artist? {
        var artist: Artist?
        
        if isFiltering() {
            artist = fileterdDataArray[indexPath.row]
        } else {
            artist = artists[indexPath.row]
        }
        return artist
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
        guard let artistObj = artist(forIndexPath: indexPath),let artistName = artist(forIndexPath: indexPath)?.displayName, let artistOnTourUntil = artistObj.onTourUntil else {
            return cell
        }
        
        cell.blurredImage.image = UIImage(named: artistName) ?? UIImage.placeholder()
        cell.unBlurredImage.image = UIImage(named: artistName) ?? UIImage.placeholder()
        cell.artistConcertPlace.text = "Tour until∙\(artistOnTourUntil)"
        cell.artistNameLabel.text = artistObj.displayName
        cell.concertDateLabel.text = "Click for more info"
        
        return cell
        
    }
    
}

protocol ActorChosenDelegate: class {
    func searchTextRecieved(artist:Artist)
}

extension MainViewController: ActorChosenDelegate {
    
    func searchTextRecieved(artist: Artist) {
        artist.writeToRealm()
        self.actorsTableView.reloadData()
    }
}





