//
//  SuggestionsList.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import SwiftUI

struct ResultsList: View {
    @EnvironmentObject var placeManager: PlaceManager
    
    var body: some View {
        List {
            ForEach(placeManager.places) { place in
                PlaceRow(place: place)
                    .onTapGesture {
                        print(place)
                    }
            }
        }.listStyle(.plain)
    }
}

struct SuggestionsList_Previews: PreviewProvider {
    static var previews: some View {
        ResultsList()
    }
}
