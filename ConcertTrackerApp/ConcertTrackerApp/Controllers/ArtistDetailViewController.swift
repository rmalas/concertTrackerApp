//
//  ArtistDetailViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/27/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController {
    
    var counter:Int?

    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
        textField.textColor = UIColor.white
        setUpDesign()
        RequestManager.shared.getUpcommingEvents(artistID: counter!) { (event) in
            var counter = 0
            for item in event {
                counter += 1
                guard let eventName = item.displayName else { return }
                guard let eventPlace = item.location?.city else { return }
                let finalString = String("\(counter))" + eventName + "," + eventPlace + "\n\n")
                DispatchQueue.main.async {
                    self.textField.text.append(finalString)
                }
            }
        }
    }
    
    func setUpDesign() {
        view.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 52.0/255, alpha: 1)
    }
}
