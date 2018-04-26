

import Foundation
import RealmSwift


struct SearchArtist_Info:Decodable {
    let status: String?
    let results: Results<Artist>?
    let perPage: Int?
    let page: Int?
    let totalEntries: Int?
}






















































