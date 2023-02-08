//
//  Place.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import Foundation
import CoreLocation

class Place: Identifiable {
    var id = UUID()
    var name: String = ""
    var address: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
}

extension Place: Hashable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        lhs.name == rhs.name && lhs.address == rhs.address && lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(name)\(lat)\(lng)\(address)")
    }
}

extension Place: CustomStringConvertible {
    var description: String {
        """
            name = \(name)
            address = \(address)
            lat = \(lat)
            lng = \(lng)
        """
    }
}
