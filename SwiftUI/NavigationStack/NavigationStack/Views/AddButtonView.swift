//
//  AddButtonView.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 20.06.22.
//

import SwiftUI

struct AddButtonView: View {
    @State var isSheetShown: Bool = false
    
    var body: some View {
        Button {
            isSheetShown = true
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Add")
            }
        }.sheet(isPresented: $isSheetShown) {
            FetchingDataView()
        }
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
    }
}
