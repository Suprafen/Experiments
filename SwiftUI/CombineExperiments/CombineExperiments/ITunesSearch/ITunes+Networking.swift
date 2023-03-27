
import Foundation
import SwiftyJSON

class ITunesNetworkManager {
    
    enum ITunesNetworkManagerError: Error {
        case unableToGetDictionaries
        case unableToConverStringLiteralToURL
        case unableToUnwrapResults
    }
    
    init() {}

    func getData(from strURL: String) async throws -> [Product] {
        
        guard let url = URL(string: strURL) else { throw ITunesNetworkManagerError.unableToConverStringLiteralToURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw ITunesNetworkManagerError.unableToGetDictionaries }
        
        let json = JSON(data)
        
        let products = Product.decode(from: json)
        
        return products
    }
}

enum APIEndpoint: String {
    
    private func baseURL() -> String {
        "https://itunes.apple.com/"
    }
    
    case search = "search?"
    
    func urlString( searchQuery: String, with parameters: [String: String]? = nil) -> String {
        let encodedSearchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "UNABLE_TO_ENCODE"
        
        var queries: String = ""
        
        if let parameters {
            queries = parameters.map { "&\($0.key)=\($0.value)" }.joined()
        }
        
        return baseURL() + self.rawValue + "term=\(encodedSearchQuery)" + queries
    }
}
