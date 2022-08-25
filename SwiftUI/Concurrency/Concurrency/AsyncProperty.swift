//
//  ContentView.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 28.06.22.
//

import SwiftUI

extension URLSession {
    static let noCacheSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        return URLSession(configuration: config)
    }()
}

fileprivate struct RemoteFile<T: Decodable> {
    let url: URL
    let type: T.Type
    
    var contents: T {
        get async throws {
            let (data, _) = try await URLSession.noCacheSession.data(from: url)
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
}

fileprivate struct Message: Decodable, Identifiable {
    let id: Int
    let user: String
    let text: String
}


struct AsyncProperty: View {
    private let source = RemoteFile(url: URL(string: "https://hws.dev/inbox.json")!, type: [Message].self)
    @State private var messages = [Message]()
    
    var body: some View {
        NavigationView {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.user)
                        .font(.headline)
                    Text(message.text)
                }
            }
            .navigationTitle("Inbox")
            .toolbar {
                Button(action: refresh) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            }
            .onAppear(perform: refresh)
        }
    }

    func refresh() {
        Task {
            do {
                messages = try await source.contents
            } catch {
                print("Message update failed.")
            }
        }
    }
    
    func tasking() async {
        let newTask = Task(priority: .background) { () -> Int in
            print("Some stuff goes here!")
            
            return 100_000
        }
        do {
            let valueFromTask = await newTask.value
        } catch {
            print(error)
        }
    }
    
}
