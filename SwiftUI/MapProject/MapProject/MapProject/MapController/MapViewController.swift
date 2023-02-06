//
//  MapViewController.swift
//  MapProject
//
//  Created by Ivan Pryhara on 1.02.23.
//

import Foundation
import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    let map = GMSMapView(frame: .zero)
    var isAnimating: Bool = false
    
    override func loadView() {
        super.loadView()  // Apple's docs say we should not call super!
        self.view = map
        
        map.isBuildingsEnabled = false
        
    }
}
