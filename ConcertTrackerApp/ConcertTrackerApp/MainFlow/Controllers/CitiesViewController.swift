//
//  CitiesViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 8/2/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    //MARK: Properties
    var citiesArray = [String]()

    
    //MARK: Actions
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add city", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            guard let text = textField?.text else { return }
            self.citiesArray.append(text)
            DefaultsSaver.shared.saveToDefaults(city: self.citiesArray)
            self.citiesTableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)

        
        
    }
    
    //MARK: Outlets
    @IBOutlet weak var citiesTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        designSetUps()
        loadDataToTableView()
        
    }
    
    func loadDataToTableView() {
        citiesArray = DefaultsSaver.shared.retrieveFromDefaults()
        citiesTableView.reloadData()
    }
    
    func designSetUps() {
        self.navigationController?.navigationBar.barTintColor = DesignSetUps.whiteColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCityConcerts",let cell = sender as? CityTableViewCell {
        let vc = segue.destination as! CityConcertsViewController
            guard let cellIndexPath = citiesTableView.indexPath(for: cell) else {
                return
            }
            vc.city = citiesArray[cellIndexPath.row]
        }
     }
}

extension CitiesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        
        cell.cityLabel.text = citiesArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            citiesArray.remove(at: indexPath.row)
            DefaultsSaver.shared.saveToDefaults(city: citiesArray)
            self.citiesTableView.reloadData()
        }
    }
    
    
}
