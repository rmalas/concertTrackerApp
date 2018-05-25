//
//  RequestManager.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 4/26/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    static let shared = RequestManager()
    
//    func searchSimilarArtist(id artistId: Int, completion: (_ artist: [Artist]) -> Void) {
//        let request = GetSimilarArtistRequest()
//        request.artistId = artistId
//        guard let url = URL(string: request.requestUrl) else { return }
//        let session = URLSession.shared
//        let task = session.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//
//            let decodedData = try JSONDecoder().decode(SearchPage<Artist>.self, from: data)
//
//        }
//        task.resume()
//    }
    
    
    
    func searchArtist(name artistName: String, completion: @escaping (_ artists: [Artist]) -> Void) throws {
        let request = GetArtistByNameRequest()
        request.artistQuery = artistName
        guard let url = URL(string: request.requestUrl) else { throw Failure(message: "Invalid request URL") }
        Alamofire.request(url).responseData(completionHandler: { (response) in
            switch (response.result) {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(SearchPage<Artist>.self, from: data)
                    guard let resultPage = decodedResponse.resultsPage, let results = resultPage.results, let artists = results.info else {
                        throw Failure(message: "Invalid JSON data")
                    }
                    completion(artists)
                } catch (let error) {
                    print(error)
                    // TODO: handle error
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
    
    func getEventDetails(eventID id: Int, completion: @escaping (_ eventDetails: EventDetails_EventInfo) -> Void) {
        guard let url = URL(string: "http://api.songkick.com/api/3.0/events/\(id).json?apikey=\(Constants.API.key)") else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, error, _) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(EventDetails_ResultsPage.self, from: data)
                guard let info = users.resultsPage.results?.event else { return }
                DispatchQueue.main.async {
                    completion(info)
                }
            } catch { print(error) }
        }
        task.resume()
    }
    
    func getUpcommingEvents(artistID id:Int, completion: @escaping (_ concert: [Event]) -> Void) throws {
        let request = GetArtistUpcomingEventsRequest()
        request.artistId = id
        guard let url = URL(string: request.requestUrl) else { throw Failure(message: "Invalid request URL") }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let eventsSearchResult = try JSONDecoder().decode(SearchPage<Event>.self, from: data)
                
                guard let events = eventsSearchResult.resultsPage?.results?.info else {
                    completion([Event]())
                    return
                }
                completion(events)
            } catch (let decodingError) {
                print( decodingError)
            }
        }
        task.resume()
    }
    
    func getDataWithCityName(name cityName: String) throws {
        let request = GetVenueByCityNameRequest()
        request.artistQuery = cityName
        guard let url = URL(string: request.requestUrl) else { throw Failure(message: "Invalid request URL") }
        Alamofire.request(url).responseString { (response) in
            switch (response.result) {
            case .failure(let error):
                print(error)
            case .success(let responseString):
                let data = responseString.data(using: String.Encoding.utf8)
                do {
                    let responseWithParsedData = try JSONDecoder().decode(SearchVenueByCityNameResults.self, from: data!)
                    for item in (responseWithParsedData.resultsPage?.results.location)! {
                        print(item.metroArea.displayName)
                    }
                    print(responseWithParsedData)
                } catch (let error) {
                    print(error)
                }
            }
        }
    }
    
    
    func searchByVenueId(id venueId: Int,completion: @escaping (_ venue: [Venue]) -> Void) throws {
        let request = GetVenueById()
        request.venueId = venueId
        guard let url = URL(string: request.requestUrl) else { throw Failure(message: "Invalid request URL") }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let venue = try JSONDecoder().decode(SearchPage<Venue>.self, from: data)
                print(venue)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getDataWithVenueName(name venueName: String, completion: (_ city: City) -> Void) {
        let request = GetVenueByNameRequest()
        request.artistQuery = venueName
        guard let url = URL(string: request.requestUrl) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, error, _) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(VenuesSearch_ResultsPage.self, from: data)
                print(users)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    
}
