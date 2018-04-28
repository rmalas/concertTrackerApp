//
//  ViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/19/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalDesignSetUps()
        
    }
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func additionalDesignSetUps() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1) // navigationBar color setUp
        view.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 244.0/255, green: 0, blue: 61.0/255, alpha: 1) // navigationBarItems color setUp
        
        self.actorsTableView.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)

        let attributes: [NSAttributedStringKey:Any] = [NSAttributedStringKey.foregroundColor: UIColor(red: 255.0/255, green: 255.0/255, blue: 255.0/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = attributes // Navigation title color setUp with attributes
    }
    
}




extension ViewController: SearchViewControllerDelegate {
    func searchTextReceived(searchText: String, onTour: String,artID: Int) {
        
        let contains = dataArray.contains{ $0.name == searchText }
        
        if (!contains){
        let actorsObject = Actors(name: searchText, onTourUntil: onTour,artistID: artID)
            dataArray.append(actorsObject)
            let annimatedAtIndexPath = IndexPath(row: dataArray.count-1, section: 0)
            DispatchQueue.main.async {
                self.actorsTableView.beginUpdates()
                self.actorsTableView.insertRows(at: [annimatedAtIndexPath], with: .automatic)
                self.actorsTableView.endUpdates()
            }
            
            //self.actorsTableView.reloadData()
        }
    }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destinationVC = ArtistDetailViewController()
//        navigationController?.pushViewController(destinationVC, animated: true)
        
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "ArtistDetailViewController") as! ArtistDetailViewController
        secondVC.counter = dataArray[indexPath.row].artistID
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CustomTableViewCell
        
        cell.blurredImage.image = UIImage(named: "\(dataArray[indexPath.row].name)") ?? UIImage(named: "Rita Ora")
        cell.unBlurredImage.image = UIImage(named: "\(dataArray[indexPath.row].name)") ?? UIImage(named: "Rita Ora")
        cell.artistConcertPlace.text = "Tour until∙\(String(describing: dataArray[indexPath.row].onTourUntil))"
        cell.artistNameLabel.text = dataArray[indexPath.row].name
        cell.concertDateLabel.text = "Click for more info \(dataArray[indexPath.row].artistID)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}




