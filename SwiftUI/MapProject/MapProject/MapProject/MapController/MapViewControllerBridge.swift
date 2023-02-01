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
  func makeUIViewController(context: Context) -> MapViewController {
    return MapViewController()
  }

  func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
      // Update the map for each marker
      markers.forEach { $0.map = uiViewController.map }
  }
}
