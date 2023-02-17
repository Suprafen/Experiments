//
//  Anchor.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation

class Anchor: Feature<Anchor.Properties> {
    struct Properties: Codable {
        let addressId: String?
        let unitId: UUID
    }
}
