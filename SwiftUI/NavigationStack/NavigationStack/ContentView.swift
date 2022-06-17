//
//  ContentView.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 17.06.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            CustomIconView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
        
    }
}
