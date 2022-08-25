//
//  File.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 25.08.22.
//

import Foundation

struct NewsItem: Decodable {
    let id: Int
    let title: String
    let url: URL
}

struct HighScore: Decodable {
    let name: String
    let score: Int
}


func fetchUpdates() async {
    let newsTask = Task { () -> [NewsItem] in
        let url = URL(string: "https://hws.dev/headlines.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([NewsItem].self, from: data)
    }
    
    let highScoreTask = Task { () -> [HighScore] in
        let url = URL(string: "https://hws.dev/scores.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([HighScore].self, from: data)
    }
    
    do {
        let news = try await newsTask.value
        let highScores = try await highScoreTask.value
        print("Latest news loaded with \(news.count) items.")
        
        if let topScore = highScores.first {
            print("\(topScore.name) has the highest score with \(topScore.score), out of \(highScores.count) total results.")
        }
        
    } catch {
        print("There's an error!")
    }
}
