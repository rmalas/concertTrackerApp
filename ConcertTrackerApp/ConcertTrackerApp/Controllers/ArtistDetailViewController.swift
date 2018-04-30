//
//  ArtistDetailViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell",for: indexPath) as! ArtistDetailTableViewCell
        
        let event = events[indexPath.row]
        cell.artistNameLabel.text = event.displayName
        guard let location = event.location?.city, let startDate = event.start?.date, let startTime = event.start?.time else { return cell }
        cell.artistConcertInfoLabel.text = ("Time:\(startDate), at \(startTime)")
        return cell
    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    
    var events: [Event] = []
    
    
    @IBOutlet weak var concertDetails: UITableView!
    
    
    var counter:Int?
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.concertDetails.rowHeight = UITableViewAutomaticDimension
        
        setUpDesign()
        RequestManager.shared.getUpcommingEvents(artistID: counter!) { (event) in
            if let events = event.results.event {
                self.events = events
            }
            self.concertDetails.reloadData()
        }
        
        self.concertDetails.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)

    }
    
    func setUpDesign() {
        view.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
    }
}
