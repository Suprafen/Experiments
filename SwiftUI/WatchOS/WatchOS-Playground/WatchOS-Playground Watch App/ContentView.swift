//
//  ContentView.swift
//  WatchOS-Playground Watch App
//
//  Created by Ivan Pryhara on 7.09.22.
//

import SwiftUI

struct Item: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var content: String
}


struct imageItem: Codable, Hashable, Identifiable {
    var id: Int
    var title: String
    var url: URL
    var thumbnailUrl: URL
}

struct ContentView: View {
    @State private var presentedItems: [imageItem] = []
    @State var imageItems: [imageItem] = []
    
    var body: some View {
        if imageItems.isEmpty {
            Button {
                getData()
            } label: {
                Image(systemName: "arrow.down.app")
                    .foregroundColor(.blue)
            }
        } else {
            NavigationStack(path: $presentedItems) {
                List(imageItems) { item in
                    
                    
                    NavigationLink(item.title, value: item)
                }
                .navigationDestination(for: imageItem.self) { item in
                    VStack {
                        HStack {
                            VStack {
                                Image(systemName: "list.bullet.rectangle")
                                Text("\(item.url)")
                            }
                            Spacer()
                            Button {
                                presentedItems.removeAll()
                            } label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .foregroundColor(.yellow)
                            }
                            .buttonStyle(.plain)
                        }.padding([.leading, .trailing], 20)
                        Divider()
                        // Exclude the opened item from the list
                        List(imageItems.filter {$0 != item }) { item in
                            NavigationLink(item.title, value: item)
                        }.navigationDestination(for: imageItem.self) { item in
                            
                            Image(systemName: "list.bullet.rectangle")
                            Text("\(item.url)")
                        }
                    }
                }
            }
        }
    }
    
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print("There's something wrong:")
                    return
                }
                let results = try JSONDecoder().decode([imageItem].self, from: data)
                
                self.imageItems = results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
