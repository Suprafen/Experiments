//
//  Continuation.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 18.07.22.
//

import SwiftUI


struct Continuation: View {
    
    private struct Message: Decodable, Identifiable {
        let id: Int
        let from: String
        let message: String
    }

    @State private var messages: [Message] = []
    
    var body: some View {
        List(messages, id: \.self.id) { message in
            VStack {
                HStack {
                    Text("From: ").font(.headline)
                    Text(message.from)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text(message.message).font(.callout)
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                messages = await fetchMessages()
            }
        }
        .refreshable {
            Task {
                messages = await fetchMessages()
            }
        }
    }
    
    private func fetchMessages(completion: @escaping ([Message]) -> Void) {
        let url = URL(string: "https://hws.dev/user-messages.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                    completion(messages)
                    return
                }
            }
            completion([])
        }.resume()
    }
    
    private func fetchMessages() async -> [Message] {
        await withCheckedContinuation{ continuation in
            fetchMessages { messages in
                continuation.resume(returning: messages)
            }
        }
    }
}

struct Continuation_Previews: PreviewProvider {
    static var previews: some View {
        Continuation()
    }
}
