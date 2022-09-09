//
//  TaskGroups.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 8.09.22.
//

import SwiftUI

struct TaskGroups: View {
    @State var text: String = ""
    var body: some View {
        Button("Get strings", action: {Task { await printMessages() } })
        Text(text)
    }
    
    func printMessages() async {
        let string = await withTaskGroup(of: String.self) { group in
            group.addTask { "Hello"}
            group.addTask { "world"}
            group.addTask { "this is awesome"}
            
            var collected = [String]()
            
            for await value in group {
                collected.append(value)
            }
            
            return collected.joined(separator: " ")
        }
        text = string
        print(string)
    }
}

struct TaskGroups_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroups()
    }
}
