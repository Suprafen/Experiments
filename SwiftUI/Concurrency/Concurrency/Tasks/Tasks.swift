//
//  Tasks.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 25.08.22.
//

import SwiftUI

fileprivate struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let text: String
}

struct Tasks: View {
    @State private var messages = [Message]()
    var body: some View {
        NavigationView {
            Group {
                if messages.isEmpty {
                    Button("Load Messages") {
                        Task {
                            await loadMessages()
                        }
                    }
                } else {
                    List(messages) { message in
                        VStack {
                            Text(message.from)
                                .font(.headline)
//
                            Text(message.text)
                        }
                    }
                }
            }
        }.navigationTitle("Inbox")
    }
    
    func loadMessages() async {
        do {
            let url = URL(string: "https://hws.dev/messages.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        } catch {
            messages = [
                Message(id: 0, from: "Failed to load inbox.", text: "Please try again later.")
            ]
        }
    }
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        Tasks()
    }
}
