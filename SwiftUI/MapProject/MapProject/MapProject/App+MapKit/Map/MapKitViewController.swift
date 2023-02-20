//
//  MapKitViewController.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation
import CoreLocation
import MapKit

class MapKitViewController: UIViewController, MKMapViewDelegate {
    
    let imdfDirectory = Bundle.main.resourceURL!.appendingPathComponent("IMDFData")
    private let locationManager = CLLocationManager()
    
    var venue: Venue?
    private var levels: [Level] = []
    private var currentLevelFeatures = [StylableFeature]()
    private var currentLevelOverlays = [MKOverlay]()
    private var currentLevelAnnotations = [MKAnnotation]()
    var labelAnnottationViewIdentifier = "LabelAnnotationViewIdentifier"
    var pointAnnotationViewIdentifier = "PointAnnotationViewIdentifier"
    
    var mapView: MKMapView = {
       let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        mapView.frame = view.frame
        view.addSubview(mapView)
        
        mapView.delegate = self
//        self.mapView.register(PointAnnotationView.self, forAnnotationViewWithReuseIdentifier: pointAnnotationViewIdentifier)
//        self.mapView.register(LabelAnnotationView.self, forAnnotationViewWithReuseIdentifier: labelAnnotationViewIdentifier)
        
        do {
            let imdfDecoder = IMDFDecoder()
            venue = try imdfDecoder.decode(imdfDirectory)
            
        } catch let error {
            print(error)
        }
        
        showFeatureForOrdinal(1)
    }
    /// ordinal represents the total floors in the building
    private func showFeatureForOrdinal(_ ordinal: Int) {
        guard self.venue != nil else {
            return
        }

        // Clear out the previously-displayed level's geometry
        self.currentLevelFeatures.removeAll()
        self.mapView.removeOverlays(self.currentLevelOverlays)
        self.mapView.removeAnnotations(self.currentLevelAnnotations)
        self.currentLevelAnnotations.removeAll()
        self.currentLevelOverlays.removeAll()

        // Display the level's footprint, unit footprints, opening geometry, and occupant annotations
        if let levels = self.venue?.levelsByOrdinal[ordinal] {
            for level in levels {
                self.currentLevelFeatures.append(level)
                self.currentLevelFeatures += level.units
                self.currentLevelFeatures += level.openings
                
                let occupants = level.units.flatMap({ $0.occupants })
                let amenities = level.units.flatMap({ $0.amenities })
                self.currentLevelAnnotations += occupants
                self.currentLevelAnnotations += amenities
            }
        }
        
        let currentLevelGeometry = self.currentLevelFeatures.flatMap({ $0.geometry })
        self.currentLevelOverlays = currentLevelGeometry.compactMap({ $0 as? MKOverlay })

        // Add the current level's geometry to the map
        self.mapView.addOverlays(self.currentLevelOverlays)
        self.mapView.addAnnotations(self.currentLevelAnnotations)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer: MKOverlayPathRenderer
        
        switch overlay {
        case is MKMultiPolygon:
            renderer = MKMultiPolygonRenderer(overlay: overlay)
        case is MKPolygon:
            renderer = MKPolygonRenderer(overlay: overlay)
        case is MKMultiPolyline:
            renderer = MKMultiPolylineRenderer(overlay: overlay)
        case is MKPolyline:
            renderer = MKMultiPolylineRenderer(overlay: overlay)
            
        default:
            return MKOverlayRenderer(overlay: overlay)
        }
        
        renderer.lineWidth = 1.0
        renderer.strokeColor = UIColor(named: "DefaultStroke")
        renderer.fillColor = UIColor(named: "DefaultFill")
        
        return renderer
    }
}
