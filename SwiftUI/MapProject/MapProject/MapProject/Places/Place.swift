//
//  Place.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import Foundation
import CoreLocation
import SwiftyJSON

class Place: Identifiable {
    var id = UUID()
    var name: String = ""
    var address: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    var open: Bool = true
    var rating: Double = 0.0
    var placeID: String = ""
    var placeDetails: PlaceDetails?
    
    init() {
        
    }
    
    init(id: UUID = UUID(),
         name: String,
         address: String,
         lat: Double,
         lng: Double,
         open: Bool,
         rating: Double,
         placeID: String,
         placeDetails: PlaceDetails? = nil) {
        self.id = id
        self.name = name
        self.address = address
        self.lat = lat
        self.lng = lng
        self.open = open
        self.rating = rating
        self.placeID = placeID
        self.placeDetails = placeDetails
    }
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
            placeID = \(placeID)
            placeDEtails = \(placeDetails?.openHoursWeekDayText)
        """
    }
}


extension Place {
    
    static func decodeAllPlaces(forData data: Any) -> [Place] {
        
        let json = JSON(data)
        
        guard let results = json["results"].array else { return [] }
        
        var places = [Place]()
        
        for result in results {
            guard let place = decodePlace(forData: result) else { continue }
            places.append(place)
        }
        
        return places
    }
    
    static func decodePlace(forData data: Any) -> Place? {
        
        let placeData = JSON(data)
        let place = Place()
        
        if let placeName = placeData["name"].string {
            place.name = placeName
        }
        
        if let placeID = placeData["place_id"].string {
            place.placeID = placeID
        }
        
        if let address = placeData["formatted_address"].string {
            place.address = address
        }
        
        if let rating = placeData["rating"].double {
            place.rating = rating
        }
        
        if let openingHours = placeData["opening_hours"].dictionary {
            if let openNow = openingHours["open_now"]?.bool {
                place.open = openNow
            }
        }
        
        if let geometry = placeData["geometry"].dictionary {
            if let location = geometry["location"]?.dictionary,
               let lat = location["lat"]?.double, let lng = location["lng"]?.double {
                
                place.lat = lat
                place.lng = lng
            }
        }
        
        return place
    }
}
