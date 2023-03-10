//
//  PathView.swift
//  Shapes
//
//  Created by Ivan Pryhara on 10.03.23.
//

import Foundation
import SwiftUI

struct PathView: View {
    var body: some View {
        
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.closeSubpath()
        }
        .stroke(.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        
    }
}
