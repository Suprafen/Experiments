//
//  DirectionManager.swift
//  MapProject
//
//  Created by Ivan Pryhara on 6.02.23.
//

import Foundation
import GoogleMaps
import SwiftyJSON

class DirectionManager {
    
    func makeRequest(forURL url: URL) async throws {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw DirectionError.getDirectionFailure }
        print("SUCCESS")
        print(String(data: data, encoding: .utf8))
        
        let returnedData = JSON(data)
        
    }
    
    func buildURL(origin: String, destination: String) -> URL {
        URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=")!
    }
}

enum DirectionError: String, Error {
    case getDirectionFailure = "Impossible to get direction"
}
