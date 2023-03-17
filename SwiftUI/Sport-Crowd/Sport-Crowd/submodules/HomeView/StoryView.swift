//
//  StoryView.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 16.03.23.
//

import SwiftUI
import UIKit

struct StoryView: View {
    
    @Binding var storyWatched: Bool
    
    private var width: Double
    private var height: Double
    private var storyImage: Image
    
    init(width: Double, height: Double, storyWatched: Binding<Bool>, storyImage: Image) {
        self.width = width
        self.height = height
        self._storyWatched = storyWatched
        self.storyImage = storyImage
    }
    
    var body: some View {
        ZStack {
            ZStack {
                storyImage
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(x: 0.6, y: 0.6)
                    
                Circle()
                    .opacity(0.1)
            }
            .frame(width: width * 0.95, height: height * 0.95)
            // TODO: Make the view animatable after tapping on it, like instagram does.
            CircleShape(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
                .strokeBorder(
                    LinearGradient(
                        colors: [.purple, .purple, .pink, .red,.orange, .yellow, .yellow],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    )
                    , style: StrokeStyle(lineWidth: width * 0.05, lineCap: .round, lineJoin: .round))
                .frame(width: width, height: height)
                .opacity(storyWatched ? 0 : 1)
        }
    }
}

private struct CircleShape: InsettableShape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0

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
