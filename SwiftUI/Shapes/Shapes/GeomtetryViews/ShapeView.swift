//
//  ShapeView.swift
//  Shapes
//
//  Created by Ivan Pryhara on 10.03.23.
//

import Foundation
import SwiftUI

fileprivate struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        
        return path
    }
}

fileprivate struct Arc: Shape {
    
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        // MARK: Useful to know this adjustment
        // In a few words it transofrms SwiftUI's standart
        // drawing rules, to more straightforward for humans to read.
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
}

struct ShapeView: View {
    var body: some View {
        VStack {
            
            Triangle()
                .stroke(.red, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
            
            Arc(startAngle: .degrees(0), endAngle: .degrees(90), clockwise: true)
                .stroke(.orange, style: StrokeStyle(lineWidth: 5))
                .frame(width: 300, height: 300)
        }
        .padding(10)
    }
}

struct ShapeView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeView()
    }
}
