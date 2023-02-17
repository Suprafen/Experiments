//
//  Direction+Decoding.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation
import SwiftyJSON

extension Direction {
    static func create(fromData data: Any) -> Direction {
        let direction = JSON(data)
        
        let newDirection = Direction()
        
        let routes = direction["routes"].arrayValue
        let returnedRoutes = Route.createAll(fromData: routes)
        
        if !returnedRoutes.isEmpty {
            newDirection.routes = returnedRoutes
        } else {
            print("Oh no, routes are empty")
        }
        
        return newDirection
    }
}
