import Foundation

class Product: Identifiable{
    var id = UUID()
    var trackName: String = ""
    var artistName: String = ""
    
    init(artistName: String, trackName: String) {
        self.artistName = artistName
        self.trackName = trackName
    }
}

extension Product: Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id && lhs.trackName == rhs.trackName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(id)-\(trackName)-\(artistName)")
    }
}

// MARK: Product + Dencoding

import SwiftyJSON

extension Product {
    
    static func decode(from data: Any) -> [Product] {
        let json = JSON(data)
        
        var decodedData = [Product]()
        
        guard let results = json["results"].array else { return [] }
        
        for result in results {
            guard let artistName = result["artistName"].string,
                  let trackName = result["trackName"].string else { continue }
            
            decodedData.append(Product(artistName: artistName, trackName: trackName))
        }
        return decodedData
    }
}
