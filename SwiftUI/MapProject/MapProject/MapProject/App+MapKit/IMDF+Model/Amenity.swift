//
//  Amenity.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation
import MapKit

class Amenity: Feature<Amenity.Properties>, MKAnnotation {
    struct Properties: Codable {
        let category: String
        let name: LocalizedName?
        let unitIds: [UUID]
    }
    
    var coordinate: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    var title: String?
    var subtitle: String?
}
