//
//  TasksResult.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 7.09.22.
//

import Foundation
import SwiftUI


enum LoadError: Error {
    case fetchFailed, decodeFailed
}

struct Post: Codable, Identifiable, Hashable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
}

struct TasksResult: View {
    @State var quotes: String = ""
    @State var posts: [Post] = []
    @State var isLoading: Bool = false
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            NavigationStack {
                List(posts) { post in
                    NavigationLink(value: post) {
                        VStack {
                            HStack {
                                Text(post.title)
                                Text("\(post.userId)")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationDestination(for: Post.self) { post in
                    List {
                        Text(post.body)
                    }
                }
            }
            .onAppear {
                isLoading = posts.isEmpty
                Task {
                    await fetchPosts()
                    isLoading = false
                }
            }
        }
    }
    // MARK: Task's result
    func fetchQuotes() async {
        let fetchTask = Task { () -> [Post] in
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return try JSONDecoder().decode([Post].self, from: data)
            } catch {
                return [Post(userId: 0, id: 0, title: "Error", body: "Error")]
            }
        }
        
        let taskResult = await fetchTask.result
        
        do {
            let posts = try taskResult.get()
            
            self.posts = posts
        } catch {
            self.posts = [Post(userId: 0, id: 0, title: "Error", body: "Error")]
        }
    }
    
    // MARK: Task's value
    func fetchPosts() async {
        let fetchTask = Task { () -> [Post] in
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return try JSONDecoder().decode([Post].self, from: data)
            } catch {
                return [Post(userId: 0, id: 0, title: "Something Wrong happened", body: "Something Wrong happened")]
            }
        }
        
        let posts = await fetchTask.value
        
        self.posts = posts
    }
}
