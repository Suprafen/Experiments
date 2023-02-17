//
//  Unit.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation

class Unit: Feature<Unit.Properties> {
    struct Properties: Codable {
        let category: String
        let levelID: UUID
    }
    
    var occupants: [Occupant] = []
    var amenities: [Amenity] = []
}
