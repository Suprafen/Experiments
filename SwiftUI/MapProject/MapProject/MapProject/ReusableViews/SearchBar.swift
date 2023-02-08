//
//  SearchBar.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchQuerry: String
    
    var body: some View {
        TextField("Start typing...", text: $searchQuerry)
            .textFieldStyle(.roundedBorder)
    }
}

