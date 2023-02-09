//
//  PlaceDetailsView.swift
//  MapProject
//
//  Created by Ivan Pryhara on 9.02.23.
//

import SwiftUI

struct PlaceDetailsView: View {
    var place: Place
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: NavBar(kind of)
                HStack {
                    VStack(alignment: .leading) {
                        Text(place.name)
                            .font(.largeTitle)
                            .bold()
                        Text(place.address)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    Spacer()
                }
                .padding([.top, .leading, .trailing], 20)
                // MARK: Open/Close
                HStack {
                    Text(place.open ? "Open" : "Closed")
                        .font(.title3)
                        .foregroundColor(place.open ? .green : .red)
                    
                    VStack(alignment: .trailing) {
                        HStack {
                            Text("•")
                                .font(.title)
                            Text(place.rating.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", place.rating) : "\(place.rating)")
                                .font(.title3)
                            Image(systemName: "star.fill")
                                .font(.title3)
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                    }
                    Spacer()
                }.padding([.leading, .trailing], 20)
                // MARK: Scroll view of photos that relates to the place
                RoundedRectangle(cornerRadius: 20)
                    .frame(minHeight: 300)
                    .foregroundColor(.brown.opacity(0.4))
                    .padding([.leading, .trailing], 20)
                HStack {
                    Button {
                        print("Build direction")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.blue)
                            HStack(spacing: 20) {
                                Text("Directions")
                                Image(systemName: "map.fill")
                            }
                            .font(.title2)
                            .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: 250, minHeight: 50, maxHeight: 60)
                    .layoutPriority(1)
                    
                    Button {
                        print("Build direction")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.gray.opacity(0.6))
                                .frame(minWidth: 80, maxHeight: 55)
                            Image(systemName: "ellipsis")
                                .font(.title)
                        }
                    }
                    
                }.padding([.leading, .trailing], 20)
                // MARK: Working days
                // Could be put lower in layout, cause it's not very important info
                if let placeDetails = place.placeDetails {
                    // MARK: Title of the section
                    Divider()
                        .padding([.leading, .trailing], 20)
                    HStack {
                        Text("Working days")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding([.leading, .trailing], 20)
                    HStack {
                        VStack(alignment: .leading) {
                            ForEach(placeDetails.openHoursWeekDayText, id: \.self) { openHours in
                                Text(openHours)
                                    .padding([.bottom], 5)
                            }
                        }
                        Spacer()
                    }
                    .padding([.leading, .trailing], 20)
                }
            }
        }
    }
}

struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView(place: Place(name: "Starbuck",
                                      address: "Address street 178, 1",
                                      lat: 52.1111,
                                      lng: 43.1234,
                                      open: true,
                                      rating: 4.2,
                                      placeID: "dsadadqweqwdasdqoi1o23",
                                      placeDetails:
                                        PlaceDetails(type: .cafe,
                                                     openHoursWeekDayText: ["Monday: 6:00 AM – 11:00 PM",
                                                                            "Tuesday: 6:00 AM – 11:00 PM",
                                                                            "Wednesday: 6:00 AM – 11:00 PM",
                                                                            "Thursday: 6:00 AM – 11:00 PM",
                                                                            "Friday: 6:00 AM – 11:00 PM",
                                                                            "Saturday: 6:00 AM – 11:00 PM",
                                                                            "Sunday: Closed"])))
    }
}
