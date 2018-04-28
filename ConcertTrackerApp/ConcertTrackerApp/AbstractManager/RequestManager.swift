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
    
    func getUpcommingEvents(artistID id:Int, completion: @escaping (_ concert: [Event]) -> Void) {
        guard let url = URL(string: "http://api.songkick.com/api/3.0/artists/\(id)/calendar.json?apikey=\(Constants.API.key)&per_page=50") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, error, _) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(Conecert_ResultsPage.self, from: data)
                guard let data = users.resultsPage.results.event else { return }
                for item in data {
                    print(item.displayName ?? "finished","at",item.location?.city ?? "finished")
                }
                completion(data)
            } catch {
                print(error)
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
