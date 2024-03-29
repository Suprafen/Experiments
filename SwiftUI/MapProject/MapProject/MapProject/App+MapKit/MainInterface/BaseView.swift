//
//  BaseView.swift
//  MapProject
//
//  Created by Ivan Pryhara on 17.02.23.
//

import SwiftUI
import MapKit

struct BaseView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D( latitude: 37.334_900,
                                        longitude: -122.009_020),
        latitudinalMeters: 750,
        longitudinalMeters: 750)
    
    var body: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
