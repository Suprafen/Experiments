//
//  AddOverlayButtonView.swift
//  MapProject
//
//  Created by Ivan Pryhara on 10.02.23.
//

import SwiftUI

struct AddOverlayButtonView: View {
    @Binding var isOverlayPresented: Bool
    
    var body: some View {
        Button {
            isOverlayPresented.toggle()
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.25), radius: 15, x: 0, y: 10)
                Image(systemName: "plus")
                    .font(.title3)
            }
        }

    }
}
