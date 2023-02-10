//
//  Step+Decoding.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation
import SwiftyJSON
import CoreLocation

extension Step {
    static func createAll(fromData data: Any) -> [Step] {
        let steps = JSON(data).arrayValue
        
        var newSteps = [Step]()
        
        for step in steps {
            guard let step = create(fromData: step) else { continue }
            newSteps.append(step)
        }
        
        return newSteps
    }
    
    static func create(fromData data: Any) -> Step? {
        
        let step = JSON(data)
        let newStep = Step()
        
        if let startLocation = step["start_location"].dictionary,
           let lat = startLocation["lat"]?.double,
           let lng = startLocation["lng"]?.double {
            newStep.startLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let startLocation = step["end_location"].dictionary,
           let lat = startLocation["lat"]?.double,
           let lng = startLocation["lng"]?.double {
            newStep.endLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        if let startLocation = step["poliline"].dictionary,
           let polylinePoints = startLocation["points"]?.string {
            newStep.polylinePoints = polylinePoints
        }
        
        return newStep
    }
}
