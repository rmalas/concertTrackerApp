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
    
    func searchSimilarArtist(id artistId: Int,perPage count: Int = 10, completion: @escaping (_ artist: [Artist]) -> Void) {
        let request = GetSimilarArtistRequest()
        request.artistId = artistId
        request.perPage = count
        guard let url = URL(string: request.requestUrl) else { return }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, error, _) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(SearchPage<[Artist]>.self, from: data)
                guard let info = users.resultsPage?.results?.info else { return }
                DispatchQueue.main.async {
                    completion(info)
                }
            } catch { print(error) }
        }
        task.resume()
        
    }
    
    func searchForFirstArtist(name artistName: String, completion: @escaping (_ artist: [Artist]) -> Void) {
        let request = GetArtistByNameRequest()
        request.artistQuery = artistName
        guard let url = URL(string: request.requestUrl) else { preconditionFailure() }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(SearchPage<[Artist]>.self, from: data)
                guard let resultPage = decodedResponse.resultsPage, let results = resultPage.results, let artists = results.info else {
                    throw Failure(message: "Invalid JSON data")
                }
                completion(artists)
            } catch (let error) {
                print(error)
                // TODO: handle error
            }
            
        }
        task.resume()
    }
    
    
    
    func searchArtist(name artistName: String, completion: @escaping (_ artists: [Artist]) -> Void) throws {
        let request = GetArtistByNameRequest()
        request.artistQuery = artistName
        guard let url = URL(string: request.requestUrl) else { throw Failure(message: "Invalid request URL") }
        Alamofire.request(url).responseData(completionHandler: { (response) in
            switch (response.result) {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode(SearchPage<[Artist]>.self, from: data)
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
    
    func getData() {
        guard let url = URL(string: "https://api.gettyimages.com/v3/search/images?phrase=Ed%20Sheeran&fields=preview") else { return }
        
        var request = URLRequest(url: url)
        //request.setValue("Api-Key", forHTTPHeaderField: "v52jqqk96b2jzd9p94af47rz")
        request.allHTTPHeaderFields = ["Api-Key":"v52jqqk96b2jzd9p94af47rz"]
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
            print(json)
            } catch (let errror) {
                print(error)
            }
        }.resume()
        
    }
    
    
    func getEventDetails(eventID id: Int, completion: @escaping (_ eventDetails: Event) -> Void) {
        guard let url = URL(string: "http://api.songkick.com/api/3.0/events/\(id).json?apikey=\(SongKickConstants.API.key)") else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, error, _) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(SearchPage<Event>.self, from: data)
                guard let upcommingEvent = users.resultsPage?.results?.info else { return }
                DispatchQueue.main.async {
                    completion(upcommingEvent)
                }
            } catch {
                print(error)
                
            }
        }
        task.resume()
    }
    
    
    
    func getRecommendedArtists(artistArray: [Artist],completion: @escaping (_ artistt: [Artist]) -> Void) {
        NSLog("****GETTING RECOMMENDED ARTISTS****")
        var artistList = [Artist]()
        let group = DispatchGroup()
        
        artistArray.forEach { (artist) in
            group.enter()
            RequestManager.shared.searchSimilarArtist(id: artist.id, completion: { (recommendedArtist) in
                for item in 0..<recommendedArtist.count {
                    guard let name = recommendedArtist[item].displayName else { return }
                    RequestManager.shared.getArtistImageURL(name: name, completion: { (artistImageUrl) in
                        recommendedArtist[item].artistImageURL = artistImageUrl
                    })
                    if artistList.filter({$0.id == recommendedArtist[item].id}).isEmpty {
                        artistList.append(recommendedArtist[item])
                    } else {
                        print("Array already contains \(recommendedArtist[item].displayName ?? "no value parsed")")
                    }
                }
                NSLog("****leave****")
                group.leave()
                completion(artistList)
            })
        }
    }
    
    func getMetroAreaID(name cityName: String,completion: @escaping(_ metroAreaID : MetroAreaDecoder) -> Void) {
        let request = GetMetroAreaID()
        request.cityName = cityName
        guard let url = URL(string: request.requestUrl) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data  else { return }
            do {
                let metroAreaSearchResult = try JSONDecoder().decode(MetroAreaDecoder.self, from: data)
                completion(metroAreaSearchResult)
            } catch (let decodingError) {
                print(decodingError)
            }
        }
        task.resume()
    }
    
    func getEventsWithMetroAreaID(id metroAreaID: Int,completion: @escaping(_ events: CityEventsResultsPage) -> Void) {
        let request = GetCityEventsRequest()
        request.metroAreaID = metroAreaID
        guard let url = URL(string: request.requestUrl) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let events = try JSONDecoder().decode(CityEventsResultsPage.self, from: data)
                completion(events)
            } catch (let catchingError) {
                print(catchingError)
            }
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
                let eventsSearchResult = try JSONDecoder().decode(SearchPage<[Event]>.self, from: data)
                
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
    
    func getFestivalWithId(id festivalId: Int,completion: @escaping (_ festivalInfo: FestResults) -> Void) {
        let request = GetFestivalByIdRequest()
        request.festivalQuery = festivalId
        guard let url = URL(string: request.requestUrl) else { return }
        print()
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let festival = try JSONDecoder().decode(FestResults.self, from: data)
                completion(festival)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getArtistImageURL(name artistName: String, completion:@escaping (_ artistImage: String) -> Void) {
        let request = GetArtistImageURLRequest()
        request.artistName = artistName
        guard let url = URL(string: request.requestUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        var getImageRequest = URLRequest(url: url)
        getImageRequest.allHTTPHeaderFields = ["Api-Key":"v52jqqk96b2jzd9p94af47rz"]
        
        let session = URLSession.shared
                session.dataTask(with: getImageRequest) { (data, response, error) in
                    guard let data = data else { return }
                    do {
                        let json = try JSONDecoder().decode(ImageResults.self, from: data)
                        let upcommingURL = json.images.first?.display_sizes?.first?.uri ?? ""
                        print(upcommingURL)
                        completion(upcommingURL)
                    } catch {
                        print(error)
                    }
        }.resume()
    }
    
    func loadImageWithURL(url imageURL: String,completion:@escaping (_ artistImage: UIImage) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error ?? "Error occured")
                return
            }
            guard let data = data else { return }
            let artistImage = UIImage(data: data)
            completion(artistImage!)
        }
        task.resume()
    }
    
    
    

    
    
    
}
