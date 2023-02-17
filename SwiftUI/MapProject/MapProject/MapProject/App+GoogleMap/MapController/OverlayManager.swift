//
//  OverlayManager.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import Foundation
import CoreLocation
import GoogleMaps

class OverlayManager: ObservableObject {
    
    func putImage(onMap map: GMSMapView) {
        let image = UIImage(named: "PalaceLogo")!
        
        let southWest = CLLocationCoordinate2D(latitude: 52.233116, longitude: 20.998597)
        
        let northEast = CLLocationCoordinate2D(latitude: 52.257464, longitude: 21.030457)
        
        let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
        
        let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: image)
        
        overlay.bearing = 0
        overlay.map = map
    }
}
