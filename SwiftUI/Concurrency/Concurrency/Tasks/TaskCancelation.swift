//
//  TaskCancelation.swift
//  Concurrency
//
//  Created by Ivan Pryhara on 8.09.22.
//

import SwiftUI

struct TaskCancelation: View {
    
    @State var averageTemp: Double = 0.0
    
    var body: some View {
        Button {
            Task {
                await getAverageTemperature()
            }
        } label: {
            Text("Get data.")
        }
        Text("Avg temp: \(averageTemp)")
    }
    
    func getAverageTemperature() async {
        let fetchTask = Task { () -> Double in
            let url = URL(string: "https://hws.dev/readings.json")!
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if Task.isCancelled {
                    return 0
                }
                
                let readings = try JSONDecoder().decode([Double].self, from: data)
                let sum = readings.reduce(0, +)
                return sum/Double(readings.count)
            } catch {
                // We no longer need to catch errors
                // Because we can simply return default value instead
                return 0
            }
            
        }
        // Implicit cancelation
        fetchTask.cancel()
        
        averageTemp = await fetchTask.value
        print(averageTemp)
    }
}

struct TaskCancelation_Previews: PreviewProvider {
    static var previews: some View {
        TaskCancelation()
    }
}
