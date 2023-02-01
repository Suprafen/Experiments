//
//  MapViewControllerBridge.swift
//  MapProject
//
//  Created by Ivan Pryhara on 1.02.23.
//

import Foundation
import GoogleMaps
import SwiftUI

struct MapViewControllerBridge: UIViewControllerRepresentable {
    @Binding var markers: [GMSMarker]
    @Binding var selectedMarker: GMSMarker?
    var onAnimationEnded: () -> ()
    var mapViewWillMove: (Bool) -> ()
    
  func makeUIViewController(context: Context) -> MapViewController {
      let uiViewController = MapViewController()
      uiViewController.map.delegate = context.coordinator
      return uiViewController
  }

  func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
      // Update the map for each marker
      markers.forEach { $0.map = uiViewController.map }
      selectedMarker?.map = uiViewController.map
      animateToSelectedMarker(viewController: uiViewController)
  }
    
    private func animateToSelectedMarker(viewController: MapViewController) {
        guard let selectedMarker else { return }
        
        let map = viewController.map
        
        if map.selectedMarker != selectedMarker {
            map.selectedMarker = selectedMarker
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                map.animate(toZoom: kGMSMinZoomLevel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    map.animate(with: GMSCameraUpdate.setTarget(selectedMarker.position))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        map.animate(toZoom: 12)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                            onAnimationEnded()
                        })
                    })
                }
            }
        }
    }
    
    final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapViewControllerBridge: MapViewControllerBridge
        
        init(_ mapViewControllerBridge: MapViewControllerBridge) {
            self.mapViewControllerBridge = mapViewControllerBridge
        }
        
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            self.mapViewControllerBridge.mapViewWillMove(gesture)
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
}
