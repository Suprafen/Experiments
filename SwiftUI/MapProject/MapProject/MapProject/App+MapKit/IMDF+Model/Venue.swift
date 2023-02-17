//
//  Venue.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation

class Venue: Feature<Venue.Properties> {
    struct Properties: Codable {
        let category: String
    }
    
    var levelsByOrdinal: [Int:[Level]] = [:]
}
