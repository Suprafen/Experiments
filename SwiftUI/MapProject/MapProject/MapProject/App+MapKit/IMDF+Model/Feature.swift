//
//  Feature+IMDF.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation
import MapKit

class Feature<Properties: Decodable>: NSObject, IMDFDecodableFeature {
    let identifier: UUID
    let properties: Properties
    var geometry: [MKShape & MKGeoJSONObject]
    
    required init(feature: MKGeoJSONFeature) throws {
        guard let uuidString = feature.identifier else {
            throw IMDFError.invalidData
        }
        
        if let identifier = UUID(uuidString: uuidString) {
            self.identifier = identifier
        } else {
            throw IMDFError.invalidData
        }
         
        if let propertiesData = feature.properties {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            properties = try decoder.decode(Properties.self, from: propertiesData)
        } else {
            throw IMDFError.invalidData
        }
        
        self.geometry = feature.geometry
        
        super.init()
    }
}
