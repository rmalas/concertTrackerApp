//
//  ArtistProfileViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/8/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class ArtistProfileViewController: UIViewController {
    
    weak var getActor: ArtistReceivedDelegate?
    var artistModel = Artist()
    
    @IBOutlet weak var artistProfileImage: UIImageView!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    @IBOutlet weak var dissmissButton: UIButton!
    
    var favoritesBlock: ((_ addedToFavorites: Bool) -> Void)?
    
    @IBAction func dismissButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addToFavouritesButtonClicked(_ sender: UIButton) {
        
        
            let actor = Actors(name: artistModel.displayName!, onTourUntil: artistModel.onTourUntil ?? "Tour is finished", artistID: artistModel.id!)
            actor.writeToRealm()
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        //        self.dismiss(animated: true, completion: nil)
//        favoritesBlock?(true)
    }
    
    
    override func viewDidLoad() {
        print(artistModel.displayName,artistModel.id)
        super.viewDidLoad()
        artistProfileImage.image = UIImage(named: artistModel.displayName!)
        additionalSetUps()
    }
    
    func additionalSetUps() {
        artistProfileImage.layer.cornerRadius = 15
        artistProfileImage.layer.masksToBounds = true
        view.backgroundColor = SetUpColors.whiteColor
        addToFavouritesButton.backgroundColor = SetUpColors.redColor
        addToFavouritesButton.layer.cornerRadius = 5
        addToFavouritesButton.layer.masksToBounds = true
        dissmissButton.backgroundColor = SetUpColors.redColor
        dissmissButton.layer.cornerRadius = 5
        dissmissButton.layer.masksToBounds = true
    }

}
