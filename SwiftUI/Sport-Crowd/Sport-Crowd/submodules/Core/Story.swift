//
//  Story.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 16.03.23.
//

import Foundation

class Story: Identifiable {
    var id = UUID()
    var storyName: String
    var storyImageRef: String
    var watched: Bool
    
    
    init(storyName: String, storyImageRef: String, watched: Bool = false) {
        self.storyName = storyName
        self.storyImageRef = storyImageRef
        self.watched = watched
    }
}

extension Story: Hashable {
    static func == (lhs: Story, rhs: Story) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
