//
//  Direction.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation

class Direction: Identifiable {
    let id = UUID()
    var routes: [Route] = []
    
    init() {}
    
    init(routes: [Route]) {
        self.routes = routes
    }
}
