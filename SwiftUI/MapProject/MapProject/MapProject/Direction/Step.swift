//
//  Step.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation
import CoreLocation

class Step {
    var startLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var endLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var polylinePoints: String = ""
    
    init(){}
    init(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, polylinePoints: String) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.polylinePoints = polylinePoints
    }
}
