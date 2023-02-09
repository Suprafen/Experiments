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
    
    func buildDirection(forURL url: URL, withMap map: GMSMapView) async throws {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else { throw DirectionError.getDirectionFailure }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        }
        
        DispatchQueue.main.async {
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
            
            for polyline in polylines {
                polyline.strokeColor = .systemBlue
                polyline.strokeWidth = 4
                polyline.map = map
            }
        }
    }
    
    func buildURL(origin: String, destination: String) -> URL {
        URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=\(DIRECTIONS_API_KEY)")!
    }
}

enum DirectionError: String, Error {
    case getDirectionFailure = "Impossible to get direction"
}


class PrettyJson {
    
    private init() {
    }
    
    static let shared = PrettyJson()
    
    func printPretty(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        }
    }
}
