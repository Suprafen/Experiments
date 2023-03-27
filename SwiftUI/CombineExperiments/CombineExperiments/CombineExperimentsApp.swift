//
//  CombineExperimentsApp.swift
//  CombineExperiments
//
//  Created by Ivan Pryhara on 23.03.23.
//

import SwiftUI

@main
struct CombineExperimentsApp: App {
    var body: some Scene {
        WindowGroup {
            ITunesSearchView(searchViewModel: ITunesSearchViewModel(networkManager: ITunesNetworkManager()))
        }
    }
}
