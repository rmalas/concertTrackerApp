//
//  Location.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/10/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import MapKit
import Realm
import RealmSwift

class GeoCoordinates2D: Object, Decodable {
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    
    
    
    class func coordinates(coordinates: CLLocationCoordinate2D) -> GeoCoordinates2D {
        let object = GeoCoordinates2D()
        object.latitude = coordinates.latitude
        object.longitude = coordinates.longitude
        return object
    }
    
    var coreLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}

@objc
class Location: Object, Decodable {
    @objc dynamic var city: String? = nil
    @objc dynamic var coordinates: GeoCoordinates2D? = nil
    enum CodingKeys: String,CodingKey {
        case city
        case lat
        case lng
    }
    
    
    
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let city = try container.decode(String.self, forKey: .city)
        let lng = try container.decodeIfPresent(Double.self, forKey: .lng)
        let lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        var coordinates:GeoCoordinates2D? = nil
        if lng != nil, lat != nil {
            coordinates = GeoCoordinates2D(latitude: lat!, longitude: lng!)
        }
        
        
        self.init(city: city, coordinate: coordinates)
    }
    required init() {
        super.init()
    }
    convenience init(city:String?, coordinate: GeoCoordinates2D?) {
        self.init()
        self.city = city
        coordinates = coordinate
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
}
