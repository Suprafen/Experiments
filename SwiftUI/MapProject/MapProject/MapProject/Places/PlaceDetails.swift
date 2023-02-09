
//
//  PlaceDetails.swift
//  MapProject
//
//  Created by Ivan Pryhara on 9.02.23.
//


import Foundation
import SwiftyJSON

enum POIType: String, CaseIterable {
    case cafe = "cafe"
    case supermarket = "supermarket"
    case undefined = "N/A"
}


class PlaceDetails {
    
    var type: POIType = .undefined
    var openHoursWeekDayText: [String] = []
    
    init(){}
    init(type: POIType, openHoursWeekDayText: [String]) {
        self.type = type
        self.openHoursWeekDayText = openHoursWeekDayText
    }
    
    static func decodePlaceDetails(fromData data: Any) -> PlaceDetails {
        let pdData = JSON(data)
        
        let placeDetails = PlaceDetails()
        
        if let types = pdData["types"].array {
            for type in types {
                guard let type = type.string else { continue }
                guard let poiType = POIType(rawValue: type) else { continue }
                placeDetails.type = poiType
                break
            }
        }
        
        if let currentOpeningHours = pdData["current_opening_hours"].dictionary,
           let weekdayText = currentOpeningHours["weekday_text"]?.array {
            for text in weekdayText {
                guard let text = text.string else { continue }
                placeDetails.openHoursWeekDayText.append(text)
            }
        }
        
        return placeDetails
    }
}
