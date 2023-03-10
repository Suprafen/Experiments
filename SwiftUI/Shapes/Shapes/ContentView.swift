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
                    GeometryItemLabel(title: "Path", shapeType: .path, color: .red)
                }
                NavigationLink {
                    ShapeView()
                } label: {
                    GeometryItemLabel(title: "Shape", shapeType: .shape, color: .blue)
                }
                
                NavigationLink {
                    CGAffineTransformView()
                } label: {
                    GeometryItemLabel(title: "Transform", shapeType: .path, color: .orange)
                }
                
                NavigationLink {
                    CreateBordersView()
                } label: {
                    GeometryItemLabel(title: "Creative border", shapeType: .shape, color: .purple)
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
