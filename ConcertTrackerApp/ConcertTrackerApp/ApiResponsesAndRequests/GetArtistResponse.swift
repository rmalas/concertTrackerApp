

import Foundation
import RealmSwift

//struct SearchArtist_ResultsPage: Decodable {
//    let resultsPage: SearchResultPage<T>
//}



struct SearchArtist_Info:Decodable {
    let status: String?
    let results: Results<Artist>?
    let perPage: Int?
    let page: Int?
    let totalEntries: Int?
}

struct SearchArtist_Results: Decodable {
    let artist: [SearchArtist_Artist]?
}

struct SearchArtist_Artist:Decodable {
    let displayName: String?
    let identifier: [SearchArtist_Lists]
    let uri: String?
    let onTourUntil: String?
    let id: Int?
}

struct  SearchArtist_Lists:Decodable{
    let href: String?
    let eventsHref: String?
    let mbid: String?
    let setListsHref: String?
}



















































