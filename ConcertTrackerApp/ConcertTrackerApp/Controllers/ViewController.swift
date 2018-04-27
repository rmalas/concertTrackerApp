//
//  ViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var actorsTableView: UITableView!
    
    var dataArray: [Actors] = []
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        let searchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        searchViewController.searchDelegate = self
        self.present(searchViewController, animated: true, completion: nil)
    }
    
    @IBAction func printArtistsArray(_ sender: UIBarButtonItem) {
        //print(Helper.shared.someArtistsArray)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        try! RequestManager.shared.searchArtist(name: "Adele") { (artist) in
//            print(artist[0].displayName, artist[0].onTourUntil)
//        }
    }
    
    @objc func loadList() {
        self.actorsTableView.reloadData()
    }
    
}




extension ViewController: SearchViewControllerDelegate {
    func searchTextReceived(searchText: String, onTour: String,artID: Int) {
        let actorsObject = Actors(name: searchText, onTourUntil: onTour,artistID: artID)
            dataArray.append(actorsObject)
            self.actorsTableView.reloadData()
        
    }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
        
        cell.artistConcertPlace.text = "On tourd until ∙ \(String(describing: dataArray[indexPath.row].onTourUntil))" 
        cell.artistNameLabel.text = dataArray[indexPath.row].name
        cell.concertDateLabel.text = "Click for info about: \(dataArray[indexPath.row].artistID)"
        
        return cell
        
    }
}




