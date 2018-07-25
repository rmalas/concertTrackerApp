//
//  FestivalViewController.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 6/21/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import MapKit



class FestivalViewController: UIViewController{
    
    var festival: FestResults?
    var coordinates: CLLocationCoordinate2D?
    var coords: GeoCoordinates2D?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var festivalImage: UIImageView!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var underImageInfoLabel: UILabel!
    @IBOutlet weak var nearImageInfoLabel: UILabel!
    @IBOutlet weak var ageRestrictionLabel: UILabel!
    @IBOutlet weak var festivalsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalDesignSetups()
        RequestManager.shared.getFestivalWithId(id: 32562029) { (fest) in
            
            self.festival = fest
           // self.setUpURLS()
            DispatchQueue.main.async {
                self.festivalsCollectionView.reloadData()
                self.title = "Festivals"
                self.coords = fest.resultsPage.results.event.location.coordinates
                self.setUpMapView()
                guard let startTime = fest.resultsPage.results.event.start.time else { self.nearImageInfoLabel.text = "Time is not set up yet"; return }
                guard let location = fest.resultsPage.results.event.location.city else { self.underImageInfoLabel.text = "Come back soon!City is not set up yet"; return }
                self.nearImageInfoLabel.text = location 
                self.underImageInfoLabel.text = "Events starts at \(startTime)"
                self.additionalInfoLabel.text = "Avg ticket price is 45-60$"
            }
        }
    }
    
    func setUpMapView() {
        let annotationPin = MKPointAnnotation()
        guard let coordinates = self.coords?.coreLocationCoordinate2D else { return }
        annotationPin.coordinate = coordinates
        var region = MKCoordinateRegion()
        region.center = coordinates
        region.span.latitudeDelta = 0.05
        region.span.longitudeDelta = 0.05
        mapView.addAnnotation(annotationPin)
        mapView.setRegion(region, animated: true)
        
    }
    
    func getURLS() {
        festival?.resultsPage.results.event.performance.forEach({ (urls) in
            print("*******ARTIST URLS",urls,"*************")
        })
    }
    
    func getNextURLS(currentPage page: Int,artistName name: String) {
        if self.festival?.resultsPage.results.event.performance[page].artistImageURL == nil {
        RequestManager.shared.getArtistImageURL(name: name) { (artistImageURL) in
                self.festival?.resultsPage.results.event.performance[page].artistImageURL = artistImageURL
                print("GOT IMAGE URL FOR \(name) - \(artistImageURL)")
            }
        }
    }
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            print("****CHECKING IF EXISTS")
            guard let name = festival?.resultsPage.results.event.performance else { return }
            getNextURLS(currentPage: currentPage, artistName: name[currentPage].displayName!)
            getNextURLS(currentPage: currentPage + 1, artistName: name[currentPage + 1].displayName!)
            getNextURLS(currentPage: currentPage + 2, artistName: name[currentPage + 2].displayName!)
        }
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.festivalsCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
        
    }
    
    fileprivate func additionalDesignSetups() {
        
        self.festivalImage.layer.cornerRadius = festivalImage.frame.width/2
        self.festivalImage.clipsToBounds = true
        
        
        self.navigationController?.navigationBar.barTintColor = DesignSetUps.whiteColor
        view.backgroundColor = DesignSetUps.greyColor
        festivalsCollectionView.backgroundColor = DesignSetUps.greyColor
        
        festivalsCollectionView.delegate = self
        festivalsCollectionView.dataSource = self
        
        let nib = UINib(nibName: "CarouselCollectionViewCell", bundle: nil)
        festivalsCollectionView.register(nib, forCellWithReuseIdentifier: "carouselCollectionViewCell")
        
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 120.0, height: festivalsCollectionView.frame.size.height)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        festivalsCollectionView.collectionViewLayout = floawLayout
    }

}

extension FestivalViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let headlinersCount = festival?.resultsPage.results.event.performance else { return 0 }
        
        return headlinersCount.isEmpty ? 0 : headlinersCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = festivalsCollectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        
        
        
        if let image = SDImageCache.shared().imageFromDiskCache(forKey: festival?.resultsPage.results.event.performance[indexPath.row].artistImageURL) {
            print("Getting from cache")
            DispatchQueue.main.async {
                cell.profileImageView.image = image
            }
        } else {
            print("loading data from server")
            if let imageUrl = festival?.resultsPage.results.event.performance[indexPath.row].artistImageURL {
                SDWebImageManager.shared().loadImage(with: URL(string: imageUrl), options: [], progress: nil, completed: { (image, _, error, cacheType, _, _) in
                    DispatchQueue.main.async {
                        cell.profileImageView.image = image

                    }
                    SDWebImageManager.shared().saveImage(toCache: image, for: URL(string: imageUrl))
                })
            }
        }
        
        
        guard let headliners = festival?.resultsPage.results.event.performance else {
            return cell
        }
    
        
        cell.profileNameLabel.text = headliners[indexPath.row].displayName
        
        return cell
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.festivalsCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    
    
}

