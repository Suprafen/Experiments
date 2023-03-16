//
//  StoriesScrollView.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 16.03.23.
//

import SwiftUI

struct StoriesScrollView: View {
    
    @ObservedObject private var storyVM: StoriesViewModel
    @State private var storyWatched: Bool = false
    init(storyVM: StoriesViewModel) {
        self.storyVM = storyVM
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(storyVM.stories) { story in
                    StoryView(width: 80, height: 80, storyWatched: $storyWatched, storyImage: Image(story.storyName))
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing, .bottom], 20)
    }
}

struct StoriesScrollView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesScrollView(storyVM: StoriesViewModel())
    }
}
