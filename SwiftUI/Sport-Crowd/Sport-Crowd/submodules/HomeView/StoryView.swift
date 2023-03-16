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
            Circle()
                .strokeBorder(.red, style: StrokeStyle(lineWidth: width * 0.05, lineCap: .round, lineJoin: .round))
                .frame(width: width, height: height)
                .opacity(storyWatched ? 0 : 1)
        }
    }
}
