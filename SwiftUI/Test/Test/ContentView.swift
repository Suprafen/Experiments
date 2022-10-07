//
//  ContentView.swift
//  Test
//
//  Created by Ivan Pryhara on 18.09.22.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        Text("In App push notification!")
            .font(.title)
            .fontWeight(.semibold)
            .lineSpacing(12)
            .kerning(1.1)
            .onAppear(perform: authorizeNotifications)
    }
    
    func authorizeNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

