//
//  Route+Decoding.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation
import SwiftyJSON

extension Route {
    
    static func createAll(fromData data: Any) -> [Route] {
        
        let routes = JSON(data).arrayValue
        
        var newRoutes = [Route]()
        
        for route in routes {
            guard let route = create(fromData: route) else { continue }
            newRoutes.append(route)
        }
        
        return newRoutes
    }
    
    static func create(fromData data: Any) -> Route? {
        let route = JSON(data)
        let newRoute = Route()
        
        guard let overviewPolyline = route["overview_polyline"].dictionary,
              let points = overviewPolyline["points"]?.string else { return nil }
        
        newRoute.overviewPolylinePoints = points
         
        let legs = route["legs"].arrayValue
        let returnedLegs = Leg.createAll(fromData: legs)
        
        if !returnedLegs.isEmpty {
            newRoute.legs = returnedLegs
        }
        
        return newRoute
    }
}
