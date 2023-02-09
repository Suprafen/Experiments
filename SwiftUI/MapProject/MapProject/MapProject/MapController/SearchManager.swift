//
//  SearchManager.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import Foundation
import SwiftyJSON

class SearchManager {
    
    func buildURL(withQuery query: String, radius: Int = 10_000) -> URL {
        let convertedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        
        return URL(string:"https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(convertedQuery)&radius=\(radius)&key=\(PLACES_API_KEY)")!
    }
    
    func buildURL(withPlaceID placeID: String) -> URL {
        return URL(string: "https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Ccurrent_opening_hours%2Ctype&place_id=\(placeID)&key=\(PLACES_API_KEY)")!
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
            return Place.decodeAllPlaces(forData: data)
            
        } catch {
            fatalError("Something went wrong in \(#function) -- \(error.localizedDescription)")
        }
    }
    
    func getPlaceDetails(fromURL url: URL) async -> PlaceDetails? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else { return nil }
            guard httpResponse.statusCode == 200 else {
                print("Something went wrong in \(#function) - \(httpResponse.statusCode) sttus code")
                return nil
            }
            
            let results = JSON(data)
            let placeDetails = results["result"].rawValue
//            PrettyJson.shared.printPretty(data: data)
            return PlaceDetails.decodePlaceDetails(fromData: placeDetails)
            
        } catch {
            fatalError("Something went wrong in \(#function) -- \(error.localizedDescription)")
        }
    }
    
}
