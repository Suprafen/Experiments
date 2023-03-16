//
//  TabViewController.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 16.03.23.
//

import SwiftUI

struct TabViewController: View {
    @ObservedObject private var storyVM: StoriesViewModel
    
    init(storyVM: StoriesViewModel) {
        self.storyVM = storyVM
    }
    
    var body: some View {
        TabView {
            HomeView(storyVM: storyVM)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ScheduleView()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
            BroadcastsView()
                .tabItem {
                    Label("Broadcast", systemImage: "wave.3.backward.circle")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
        }
    }
}

struct TabViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController(storyVM: StoriesViewModel())
    }
}
