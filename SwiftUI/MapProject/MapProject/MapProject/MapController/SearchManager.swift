//
//  SearchManager.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import Foundation
//import Places

class SearchManager {
    func buildURL(withQuery query: String, radius: Int = 10_000) -> URL{
        URL(string:"https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(query)&key=YOUR_API_KEY")!
    }
    
}
