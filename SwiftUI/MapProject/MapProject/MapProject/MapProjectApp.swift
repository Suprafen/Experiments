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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    GMSServices.provideAPIKey("")
                }
        }
    }
}

