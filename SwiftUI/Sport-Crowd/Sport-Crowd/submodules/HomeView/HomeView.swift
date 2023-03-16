//
//  ContentView.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 16.03.23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var storyVM: StoriesViewModel
    
    init(storyVM: StoriesViewModel) {
        self.storyVM = storyVM
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Rectangle()
                        .fill(.white)
                        .frame(height: 20)
                    StoriesScrollView(storyVM: storyVM)
                    Spacer()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                HStack {
                    Image("NBA-logo")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(x:1.7,y:1.7)
                        
                    Spacer()
                }
                .padding(.vertical, 10)
            }
        }
        
    }
}

struct HomeNavigationBar: View {
    var body: some View {
            ZStack {
                Color.clear
                    .background(.ultraThinMaterial)
                    .overlay(Divider(), alignment: .bottom)
                //FIXME: make dynamic opacity depend on scroll position
//                    .opacity(0)
                HStack {
                    Image("NBA-logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            .frame(height: 70)
            .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(storyVM: StoriesViewModel())
    }
}
