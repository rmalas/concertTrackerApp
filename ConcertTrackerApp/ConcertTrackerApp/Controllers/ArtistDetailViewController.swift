//
//  ArtistDetailViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    var events: [Event] = []
    
    @IBOutlet weak var concertDetails: UITableView!
    
    var upcommingEvents : [Event] = []
    
    var counter:Int?
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
       //var artists = DatabaseManager.shared.realm.objects(Artist.self)
       super.viewDidLoad()
       title = "Events"
       try! RequestManager.shared.getUpcommingEvents(artistID: counter!) { (events) in
            self.events = events
            self.concertDetails.reloadData()
        }
        self.concertDetails.backgroundColor = SetUpColors.whiteColor
        
    }
    
}

extension ArtistDetailViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell",for: indexPath) as! ArtistDetailTableViewCell
        
        let event = events[indexPath.row]
        cell.artistNameLabel.text = event.displayName
        let id = event.id 
        guard let startDate = event.start?.date, let startTime = event.start?.time else { return cell }
        cell.artistConcertInfoLabel.text = ("Time:\(startDate), at \(startTime), EVENT ID: \(id)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "ConcertDetailsViewController") as! ConcertDetailsViewController
        let name = events[indexPath.row].performance[0]
        secondVC.upcommingName = name.displayName ?? "Rita Ora"
        secondVC.upCommingID = events[indexPath.row].id
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
}



