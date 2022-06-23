//
//  NotationFile.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 23.06.22.
//

import SwiftUI

struct NotationFile: View {
    @State var queryText: String = ""
    
    @State var items = Array(0...1_000_000_000)
    
    var body: some View {
        List(items, id: \.self) {
            Text("\($0)")
        }
        .id(UUID())
        .searchable(text: $queryText)
    }
}

struct NotationFile_Previews: PreviewProvider {
    static var previews: some View {
        NotationFile()
    }
}
