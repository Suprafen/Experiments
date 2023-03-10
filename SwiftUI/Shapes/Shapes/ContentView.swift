//
//  ContentView.swift
//  Shapes
//
//  Created by Ivan Pryhara on 10.03.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    PathView()
                } label: {
                    // TODO: Make Corresponding rounded corners rectangles for each label
                    // Better just make a separate view
                    Text("Path")
                }
            }
            .navigationTitle("Geometry")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
