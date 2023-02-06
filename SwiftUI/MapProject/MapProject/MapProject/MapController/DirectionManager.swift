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
    @MainActor
    func makeRequest(forURL url: URL) async throws -> [GMSPolyline] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw DirectionError.getDirectionFailure }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        }
        
        let returnedData = JSON(data)
        let routes = returnedData["routes"].arrayValue
        var polylines = [GMSPolyline]()
        
        for route in routes {
            guard let overviewPolyline = route["overview_polyline"].dictionary,
                  let points = overviewPolyline["points"]?.string else { continue }
            
            let path = GMSPath(fromEncodedPath: points)
            let polyline = GMSPolyline(path: path)
            polylines.append(polyline)
        }
        
        return polylines
    }
    
    func buildURL(origin: String, destination: String) -> URL {
        return URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\("13.3648,52.5134")&destination=\("14.4326,50.0657")&key=")!
    }
}

enum DirectionError: String, Error {
    case getDirectionFailure = "Impossible to get direction"
}
