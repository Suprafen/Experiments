//
//  MapViewRepresentable.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation
import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MapKitViewController {
        let controller = MapKitViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MapKitViewController, context: Context) {
        
    }
    
}

