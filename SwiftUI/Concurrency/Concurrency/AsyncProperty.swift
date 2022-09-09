//
//  ContentView.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 28.06.22.
//

import SwiftUI

fileprivate struct Post: Codable, Identifiable, Hashable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}

fileprivate struct Comment: Codable, Identifiable, Hashable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
}


struct AsyncPropertyView: View {
    @State fileprivate var posts = [Post]()
    @State fileprivate var comments = [Comment]()
    
    var body: some View {
        NavigationStack {
            List(posts) { post in
                NavigationLink(value: post) {
                    VStack {
                        HStack {
                            Text(post.title)
                            Text("\(post.id)")
                        }
                        .padding(10)
                    }
                }
            }
            .navigationDestination(for: Post.self) { post in
                List {
                    Text(post.body)
                }
            }
            Divider()
            List (comments) { comment in
                VStack {
                    HStack {
                        Text(comment.name).font(.body)
                        Text(comment.email).font(.body)
                    }
                    HStack {
                        Text(comment.body).italic()
                    }
                }
            }
        }
        .onAppear {
            if posts.isEmpty || comments.isEmpty {
                Task {
                    await getData()
                }
            }
        }
    }
    
    func getData() async {
        async let (posts, _) = URLSession.shared.data(from: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        async let (comments, _) = URLSession.shared.data(from: URL(string: "https://jsonplaceholder.typicode.com/comments")!)
        
        do {
            let posts = try await JSONDecoder().decode([Post].self, from: posts)
            self.posts = posts
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let comments = try await JSONDecoder().decode([Comment].self, from: comments)
            self.comments = comments
        } catch {
            print(error.localizedDescription)
        }
    }
}
