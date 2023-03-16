//
//  StoriesViewModel.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 16.03.23.
//

import Foundation
import SwiftUI

class StoriesViewModel: ObservableObject {
    @Published var stories: [Story] = [
        Story(storyName: "BOS", storyImageRef: "BOS"),
        Story(storyName: "NYK", storyImageRef: "NYK"),
        Story(storyName: "LAL", storyImageRef: "LAL"),
        Story(storyName: "PHO", storyImageRef: "PHO"),
        Story(storyName: "NOP", storyImageRef: "NOP"),
        Story(storyName: "DEN", storyImageRef: "DEN"),
    ]
}
