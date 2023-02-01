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
            GMSServices.provideAPIKey("AIzaSyDnnuRNiacHJAt3lT6F3r261Go-TvjVrco")
            let latitude = 52.087939778280855
            let longitude = 21.024046742734747
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6)
            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
            self.view.addSubview(mapView)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            marker.title = "Warsaw"
            marker.snippet = "Poland"
            marker.map = mapView
            createCircle(forMapView: mapView,
                         location: CLLocationCoordinate2D(latitude: latitude,
                                                          longitude: longitude))
        }

        func createPath(_ mapView: GMSMapView) {
            let path = GMSMutablePath()
            path.add(CLLocationCoordinate2D(latitude: -33.85, longitude: 151.20))
            path.add(CLLocationCoordinate2D(latitude: -33.73, longitude: 151.41))
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 7
            polyline.strokeColor = .white
            let redPurple = GMSStrokeStyle.gradient(from: .systemRed, to: .systemPurple)
            polyline.spans = [GMSStyleSpan(style: redPurple)]
            polyline.map = mapView
        }
        
        func createCircle(forMapView mapView: GMSMapView, location: CLLocationCoordinate2D) {
            let circleCenter = location
            let circle = GMSCircle(position: circleCenter, radius: 1000)
            
            circle.strokeColor = .blue
            circle.fillColor = .systemBlue.withAlphaComponent(0.33)
            circle.map = mapView
        }
    }
}
