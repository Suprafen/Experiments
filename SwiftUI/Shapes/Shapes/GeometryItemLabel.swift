//
//  GeometryItemLabel.swift
//  Shapes
//
//  Created by Ivan Pryhara on 10.03.23.
//

import SwiftUI

fileprivate struct Arc: Shape {
    
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
}

fileprivate struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct GeometryItemLabel: View {
    
    var title: String
    var shapeType: ShapeType
    var color: Color
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(color)
                    .frame(width: 30, height: 30)
                createShape(shapeType)
            }
                Text(title)
                .font(.body)
        }
    }
    
    @ViewBuilder
    func createShape(_ shapeType: ShapeType) -> some View {
        switch shapeType {
        case .shape:
            Arc(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
                .stroke(.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .frame(width: 15, height: 15)
        case .path:
            Triangle()
                .stroke(.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .frame(width: 15, height: 15)
        }
    }
}
