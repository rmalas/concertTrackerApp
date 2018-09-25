//
//  CityConcertsViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 8/2/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class CityConcertsViewController: UIViewController {

    //MARK: Properties

    var city: String? {
        didSet {
            print(city)
        }
    }
    
    @IBOutlet weak var concertsTableView: UITableView!
    
    var upcommingData = [DecodedEvents]()
    
    //MARK: outlets
    @IBOutlet var backGroundView: UIView!

    
    //MARK: lifecylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showConcertInfoFromCity",let cell = sender as? ConcertInfoTableViewCell {
            let destinationVC = segue.destination as! ConcertDetailsViewController
            
            guard let cellIndexPath = concertsTableView.indexPath(for: cell) else {
                return
            }
            destinationVC.segueIdentifier = true
            destinationVC.upCommingID = upcommingData[cellIndexPath.row].id
        }
    }
    
    func setUpTableView() {
        if let name = city {
            RequestManager.shared.getMetroAreaID(name: name) { (metroAreaID) in
                print(metroAreaID.resultsPage.results.location[0].metroArea.id)
                for item in metroAreaID.resultsPage.results.location {
                    RequestManager.shared.getEventsWithMetroAreaID(id: item.metroArea.id, completion: { (events) in
                        print(events)
                        for item in events.resultsPage.results.event {
                            self.upcommingData.append(item)
                            DispatchQueue.main.async {
                                self.concertsTableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    
    func designSetUps() {
        concertsTableView.backgroundColor = DesignSetUps.whiteColor
        backGroundView.backgroundColor = DesignSetUps.whiteColor
    }

}

extension CityConcertsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcommingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertInfoCell", for: indexPath) as! ConcertInfoTableViewCell
        
        cell.ArtistLabel.text = upcommingData[indexPath.row].displayName
        cell.concertInfoLabel.text = "At \(upcommingData[indexPath.row].location.city ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
}
