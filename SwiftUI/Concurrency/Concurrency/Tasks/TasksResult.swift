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

func fetchQuotes(completion: @escaping (String) -> ()) async {
    let downloadTask = Task { () -> String in
        let url = URL(string: "https://hws.dev/quotes.txt")!
        let data: Data
        
        do {
            (data, _) = try await URLSession.shared.data(from: url)
        } catch {
            throw LoadError.fetchFailed
        }
        
        if let string = String(data: data, encoding: .utf8) {
            return string
        } else {
            throw LoadError.decodeFailed
        }
    }
    
    let result  = await downloadTask.result
    
    do {
        let string = try result.get()
        completion(string)
        print(string)
        
    } catch LoadError.decodeFailed {
        completion("Unable to convert quotes to text.")
        
        print("Unable to convert quotes to text.")
    } catch LoadError.fetchFailed {
        completion("Unable to fetch the quotes.")
        
        print("Unable to fetch the quotes.")
    } catch {
        completion("Unable to fetch the quotes.")
        
        print("Unknown error.")
    }
}

struct TasksResult: View {
    @State var quotes: String = ""
    var body: some View {
        VStack {
            Button {
                Task {
                    await fetchQuotes { content in
                        self.quotes = content
                    }
                }
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Get data.")
                }
                .foregroundColor(.green)
            }
            ScrollView {
                Text(quotes)
                    .italic()
            }
        }
    }
}
