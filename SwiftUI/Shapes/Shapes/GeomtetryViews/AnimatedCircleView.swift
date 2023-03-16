//
//  AnimatedCircleView.swift
//  Shapes
//
//  Created by Ivan Pryhara on 10.03.23.
//

import SwiftUI

fileprivate struct Arc: InsettableShape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0
    
    var animatableData: Angle {
        get { endAngle }
        set { endAngle = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        let rotationAdjustment = Angle.degrees(90)
        
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct AnimatedCircleView: View {
    @State private var degrees = Angle.degrees(1)
    @State private var sliderValue = 0.0
    @State private var buttonTapped = false
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .strokeBorder(Color(red: 0, green: 1, blue: 1).opacity(0.1), lineWidth: 40)
                    .frame(width: 215, height: 215)
                    
                
                Arc(startAngle: .degrees(0), endAngle: degrees, clockwise: true)
                    .strokeBorder(Color(red: 0, green: 0, blue: 1),
                                  style: StrokeStyle(lineWidth: 40,
                                                     lineCap: .round,
                                                     lineJoin: .round))
                    .frame(width: 215, height: 215)
                    .shadow(color: .black, radius: 15, x: 0, y: 0)
                
                
                Circle()
                    .strokeBorder(Color(red: 0, green: 1, blue: 0).opacity(0.1), lineWidth: 40)
                    .frame(width: 305, height: 305)
                    
                
                Arc(startAngle: .degrees(0), endAngle: degrees, clockwise: true)
                    .strokeBorder(Color(red: 0, green: 1, blue: 0),
                                  style: StrokeStyle(lineWidth: 40,
                                                     lineCap: .round,
                                                     lineJoin: .round))
                    .frame(width: 305, height: 305)
                    .shadow(color: .black, radius: 15, x: 0, y: 0)
                
                
                Circle()
                    .strokeBorder(Color(red: 1, green: 0, blue: 0).opacity(0.1), lineWidth: 40)
                
                Arc(startAngle: .degrees(0), endAngle: degrees, clockwise: true)
                    .strokeBorder(Color(red: 1, green: 0, blue: 0),
                                  style: StrokeStyle(lineWidth: 40,
                                                     lineCap: .round,
                                                     lineJoin: .round))
                    .shadow(color: .black, radius: 15, x: 0, y: 0)
            }
            
            Slider(value: $sliderValue, in: 0...360)
                .padding([.horizontal], 20)
            
            Button("Tap") {
                withAnimation {
                    degrees = Angle.degrees(360)
                }
            }
        }
    }
}

struct AnimatedCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCircleView()
    }
}
