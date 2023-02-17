//
//  Opening.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation

class Opening: Feature<Opening.Properties> {
    struct Properties: Codable {
        let category: String
        let levelID: UUID
    }
    
    var openings: [Opening] = []
}
