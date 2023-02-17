//
//  Route.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation

class Route {
    
    var legs: [Leg] = []
    var overviewPolylinePoints: String = ""
    
    init(){}
    
    init(overviewPolylinePoints: String) {
        self.overviewPolylinePoints = overviewPolylinePoints
    }
}
