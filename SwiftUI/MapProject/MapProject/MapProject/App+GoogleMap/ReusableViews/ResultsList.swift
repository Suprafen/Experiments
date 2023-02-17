//
//  SuggestionsList.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import SwiftUI

struct ResultsList: View {
    @EnvironmentObject var placeManager: PlaceManager
    @State var placeDetailsShown: Bool = false
    @State var selectedPlace: Place = Place()
    var body: some View {
        List {
            ForEach(placeManager.places) { place in
                PlaceRow(place: place)
                    .onTapGesture {
                        print(place)
                        if place.placeDetails == nil {
                            Task {
                                place.placeDetails = await placeManager.getPlaceDetails(placeID: place.placeID, placeName: place.name)
                                selectedPlace = place
                                placeDetailsShown.toggle()
                            }
                        }
                    }
            }
        }
        .listStyle(.plain)
        .sheet(isPresented: $placeDetailsShown) {
            PlaceDetailsView(place: selectedPlace)
        }
    }
}
