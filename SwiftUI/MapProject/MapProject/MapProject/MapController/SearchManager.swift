//
//  SearchManager.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import Foundation
import SwiftyJSON

class SearchManager {
    
    func buildURL(withQuery query: String, radius: Int = 10_000) -> URL{
        return URL(string:"https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(query)&radius=\(radius)&key=YOUR_API_KEY")!
    }
    
    func getPlaces(fromURL url: URL) async -> [Place] {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else { return [] }
            guard httpResponse.statusCode == 200 else {
                print("Something went wrong in \(#function) - \(httpResponse.statusCode) sttus code")
                return []
            }
            
//            PrettyJson.shared.printPretty(data: data)
            
            let json = JSON(data)
            
            guard let results = json["results"].array else { return [] }
            
            var places = [Place]()
            
            for result in results {
                
                let place = Place()
                
                if let placeName = result["name"].string {
                    place.name = placeName
                }
                
                if let address = result["formatted_address"].string {
                    place.address = address
                }
                
                if let rating = result["rating"].double {
                    place.rating = rating
                }
                
                if let openingHours = result["opening_hours"].dictionary {
                    if let openNow = openingHours["open_now"]?.bool {
                        place.open = openNow
                    }
                }
                
                if let geometry = result["geometry"].dictionary {
                    if let location = geometry["location"]?.dictionary,
                       let lat = location["lat"]?.double, let lng = location["lng"]?.double {
                        
                        place.lat = lat
                        place.lng = lng
                    }
                }
                places.append(place)
            }
            
            print(places)
            
            return places
            
        } catch {
            fatalError("Something went wrong in \(#function) -- \(error.localizedDescription)")
        }
    }
    
}
