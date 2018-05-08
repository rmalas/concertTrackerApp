//
//  ViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var notificationToken: NotificationToken? = nil
    
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
        initNotificationToken()
    }
    override func viewDidAppear(_ animated: Bool) {
        if shouldScrollToBottom {
            self.scrollToBottom()
        }
    }
    var shouldScrollToBottom = false
    
    func initNotificationToken() {
        notificationToken = dataArray.observe { [weak self] (changes: RealmCollectionChange) in
            guard let `self` = self else { return }
            switch changes {
            case .initial:
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                self.actorsTableView.beginUpdates()
                self.actorsTableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                self.actorsTableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                self.actorsTableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                self.actorsTableView.endUpdates()
                if insertions.count > 0 {
                    self.shouldScrollToBottom = true
                }
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }

        }
    }
    
    func scrollToBottom() {
        let numberOfRows = actorsTableView.numberOfRows(inSection: 0)
        let path = IndexPath(row: numberOfRows - 1, section: 0)
        if numberOfRows > 0 {
            self.actorsTableView.scrollToRow(at: path, at: .bottom, animated: true)
        }
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.actorsTableView.reloadData()
    }
    
    func deleteFromTableView(index: IndexPath) {
        let actor = dataArray[index.row]
        actor.deleteFromRealm()
        self.actorsTableView.beginUpdates()
        self.actorsTableView.deleteRows(at: [index],with: .automatic)
        self.actorsTableView.endUpdates()
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
            let destinationViewController = segue.destination as! ArtistDetailViewController
            
            guard let cellIndexPath = actorsTableView.indexPath(for: cell) else {
                return
            }
            destinationViewController.counter = dataArray[cellIndexPath.row].artistID
        }
    }
    
    
    deinit {
        notificationToken?.invalidate()
    }
}


extension ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
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
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundView = UIView()
        
        cell.backgroundView?.backgroundColor = UIColor.clear
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





