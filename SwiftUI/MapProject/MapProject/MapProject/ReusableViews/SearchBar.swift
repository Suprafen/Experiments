//
//  SearchBar.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchQuery: String
    @EnvironmentObject var placeManager: PlaceManager
    
    var body: some View {
        TextField("Start typing...", text: $searchQuery)
            .onSubmit {
                Task {
                    await placeManager.getPlaces(withQuery: searchQuery)
                }
            }
            .textFieldStyle(.roundedBorder)
    }
}
