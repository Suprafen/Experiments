//
//  MapProjectApp.swift
//  MapProject
//
//  Created by Ivan Pryhara on 31.01.23.
//

import SwiftUI
import GoogleMaps

@main
struct MapProjectApp: App {
    
    init() {
        GMSServices.provideAPIKey("")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

