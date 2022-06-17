//
//  Device.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 17.06.22.
//

import Foundation
import SwiftUI

class Device: Identifiable, Hashable {
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(model)
    }
    
    var model: String
    var type: Category
    var id = UUID()
    
    init(model: String, type: Category) {
        self.model = model
        self.type = type
    }
}


extension Device {
    static func devices(in category: Category) -> [Device]{
        switch category {
        case .iPhone:
           return  [Device(model: "iPhone 8", type: .iPhone),
                    Device(model: "iPhone 13 Pro", type: .iPhone),
                    Device(model: "iPhone 12 mini", type: .iPhone)
                    ]
        case .iPad:
            return [Device(model: "iPad mini", type: .iPad),
                    Device(model: "iPad air", type: .iPad),
                    Device(model: "iPad pro 12\"", type: .iPad)
                   ]
        case .macBook:
            return [Device(model: "MacBook Air M2", type: .macBook),
                    Device(model: "MacBook Pro M1", type: .macBook),
                    Device(model: "MacBook Pro M1 Max", type: .macBook)
                   ]
        }
    }
}
