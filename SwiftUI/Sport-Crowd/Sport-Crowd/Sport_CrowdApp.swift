//
//  Sport_CrowdApp.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 16.03.23.
//

import SwiftUI

@main
struct Sport_CrowdApp: App {
    
    @StateObject var storyVM = StoriesViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabViewController(storyVM: storyVM)
        }
    }
}
