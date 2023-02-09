//
//  PlacesManager.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import Foundation
import SwiftUI

class PlaceManager: ObservableObject {
    @Published var places: [Place] = []
    
    let searchManager = SearchManager()
    
    func getPlaces(withQuery query: String) async {
        // FIXME: Rewrite this awfulness
        let url = searchManager.buildURL(withQuery: query)
        let task = Task { () -> [Place] in
            await searchManager.getPlaces(fromURL: url)
        }
        
        let placesS = await task.value
        
        DispatchQueue.main.async {
            withAnimation {
                self.places = placesS
            }
        }
    }
    
    func getPlaceDetails(placeID: String, placeName: String) async -> PlaceDetails? {
        let url = searchManager.buildURL(withPlaceID: placeID)
        
        return await searchManager.getPlaceDetails(fromURL: url)
    }
}
