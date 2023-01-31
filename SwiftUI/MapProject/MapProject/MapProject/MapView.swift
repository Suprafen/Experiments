//
//  MapView.swift
//  MapProject
//
//  Created by Ivan Pryhara on 31.01.23.
//

import Foundation
import GoogleMaps
import SwiftUI

struct MapView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MapViewController {
        let mapViewController = MapViewController()
        
        return mapViewController
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = MapViewController

    class MapViewController: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            GMSServices.provideAPIKey("")
            
            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.2, zoom: 3)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.view.addSubview(mapView)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.2)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
        }
    }
}
