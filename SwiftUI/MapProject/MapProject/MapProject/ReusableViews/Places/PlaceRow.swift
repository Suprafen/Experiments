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
        VStack(alignment: .leading) {
            HStack(alignment: .center){
                Text(place.name)
                    .bold()
                HStack {
                    Text(place.rating.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", place.rating) : "\(place.rating)")
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            Text(place.address)
                .foregroundColor(.gray.opacity(0.5))
            Text(place.open ? "Open" : "Closed")
                .foregroundColor(place.open ? .green : .red)
        }
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRow(place: Place(name: "Lidl", address: "Grochowska", lat: 0.0, lng: 0.0, open: true, rating: 4.1))
    }
}
