//
//  MapKitViewController.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import Foundation
import MapKit

class MapKitViewController: UIViewController {
    
    var map: MKMapView = {
       let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        map.frame = view.frame
        view.addSubview(map)
    }
    
}
