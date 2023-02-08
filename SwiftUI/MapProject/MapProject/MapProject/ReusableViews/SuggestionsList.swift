//
//  SuggestionsList.swift
//  MapProject
//
//  Created by Ivan Pryhara on 8.02.23.
//

import SwiftUI

struct Suggestion: Hashable, Identifiable {
    var id = UUID()
    var body: String = ""
}

var suggestions: [Suggestion] = [
    Suggestion(body: "First"),
    Suggestion(body: "Second"),
    Suggestion(body: "Third"),
    Suggestion(body: "Fourth")
]


struct SuggestionsList: View {
    var body: some View {
        List {
            ForEach(suggestions) { suggestion in
                Text(suggestion.body)
                    .onTapGesture {
                        print(suggestion.body)
                    }
            }
        }.listStyle(.plain)
    }
}

struct SuggestionsList_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsList()
    }
}
