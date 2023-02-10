//
//  Leg+Decoding.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation
import SwiftyJSON
import CoreLocation

extension Leg {
    static func createAll(fromData data: Any) -> [Leg] {
        let legs = JSON(data).arrayValue
        var newLegs = [Leg]()
        
        for leg in legs {
            guard let leg = create(fromData: leg) else { continue }
            newLegs.append(leg)
        }
        
        return newLegs
    }
    
    static func create(fromData data: Any) -> Leg? {
        let leg = JSON(data)
        let newLeg = Leg()
        
        if let startLocation = leg["start_location"].dictionary,
           let lat = startLocation["lat"]?.double,
           let lng = startLocation["lng"]?.double {
            newLeg.startLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let startLocation = leg["end_location"].dictionary,
           let lat = startLocation["lat"]?.double,
           let lng = startLocation["lng"]?.double {
            newLeg.endLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let distance = leg["distance"].dictionary,
           let value = distance["value"]?.int {
            newLeg.distance = value
        }
        
        if let startAddress = leg["start_address"].string {
            newLeg.startAddress = startAddress
        }
        
        if let endAddress = leg["end_address"].string {
            newLeg.endAddress = endAddress
        }
        
        let steps = leg["steps"].arrayValue
        
        let returnedSteps = Step.createAll(fromData: steps)
        
        if !returnedSteps.isEmpty {
            newLeg.steps = returnedSteps
        }
        
        return newLeg
    }
}
