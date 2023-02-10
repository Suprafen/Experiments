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
        
        DispatchQueue.main.async {
            let returnedData = JSON(data)
            
            let direction = Direction.create(fromData: returnedData)
            
            // MARK: - Used to draw direct direction with high details:
//            let routes = direction.routes
//
//            guard !routes.isEmpty else { return }
//
//            let route = routes.first!
//
//            let legs = route.legs
//
//            guard !legs.isEmpty else { return }
//
//            let leg = legs.first!
//
//            guard !leg.steps.isEmpty else { return }
//
//            for step in leg.steps {
//                print(step.polylinePoints)
//                let path = GMSPath(fromEncodedPath: step.polylinePoints)
//                let polyline = GMSPolyline(path: path)
//                polyline.strokeWidth = 8
//                polyline.strokeColor = .systemBlue.withAlphaComponent(0.8)
//                polyline.geodesic = true
//                polyline.map = map
//
//            }
            
            // MARK: - Used to draw aproximate direction:
            for route in direction.routes {
                let path = GMSPath(fromEncodedPath: route.overviewPolylinePoints)
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = .systemBlue
                polyline.strokeWidth = 4
                polyline.geodesic = true
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
