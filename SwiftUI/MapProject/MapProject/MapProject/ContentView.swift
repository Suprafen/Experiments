//
//  ContentView.swift
//  MapProject
//
//  Created by Ivan Pryhara on 31.01.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapView()
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
