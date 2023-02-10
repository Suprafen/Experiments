//
//  Leg.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation
import CoreLocation

class Leg {
    var startLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var endLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    /** Distance specified in km */
    var distance: Int = 0
    var startAddress: String = ""
    var endAddress: String = ""
    
    var steps: [Step] = []
    
    init(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, distance: Int, startAddress: String, endAddress: String, steps: [Step]) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.distance = distance
        self.startAddress = startAddress
        self.endAddress = endAddress
        self.steps = steps
    }
    
    init(){}
    
}
