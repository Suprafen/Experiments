//
//  Level.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation

class Level: Feature<Level.Properties> {
    struct Properties: Codable {
        let ordinal: Int
        let category: String
        let shortName: LocalizedName
        let outdoor: Bool
        let buildingIDs: [String]?
    }
    
    var units: [Unit] = []
    var openings: [Opening] = []
}
