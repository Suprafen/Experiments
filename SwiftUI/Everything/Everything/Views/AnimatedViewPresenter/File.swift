//
//  File.swift
//  Everything
//
//  Created by Ivan Pryhara on 19.10.22.
//

import SwiftUI

struct ModalView : View {
    @Binding var activeModal: Bool
    var body : some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.activeModal = false
                }
            }) {
                Text("Hide modal")
            }
            Text("Modal View")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.green)
    }
}

struct MainView : View {
    @Binding var activeModal: Bool
    var body : some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.activeModal = true
                }
            }) {
                Text("Show modal")
            }
            Text("Main View")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.yellow)
    }
}

struct ModalContainer: View {
    @State var showingModal = false
    var body: some View {
        ZStack {
            MainView(activeModal: $showingModal)
                .allowsHitTesting(!showingModal)
                .disabled(showingModal)
            if showingModal {
                ModalView(activeModal: $showingModal)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
    }
}
