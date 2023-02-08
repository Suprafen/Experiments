//
//  PlaceRow.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import SwiftUI

struct PlaceRow: View {
    var place: Place
    
    var body: some View {
        VStack {
            Text(place.name)
                .bold()
            Text(place.address)
                .foregroundColor(.gray.opacity(0.5))
        }
    }
}
