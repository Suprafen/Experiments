//
//  ContentView.swift
//  Everything
//
//  Created by Ivan Pryhara on 19.09.22.
//

import SwiftUI
import Charts

struct Pancake: Identifiable {
    let name: String
    let sold: Int
    var id: String { name }
}

let sales: [Pancake] = [
    .init(name: "Cachapa", sold: 915),
    .init(name: "Jinga", sold: 845),
    .init(name: "Chibuba", sold: 476),
    .init(name: "Mumbaie", sold: 915),
    .init(name: "Figura", sold: 498),
    .init(name: "Zijopa", sold: 678),
    .init(name: "Moiyna", sold: 731),
]

struct PanCakesView: View {
    @Binding var query: String
    
    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 20).foregroundColor(.gray).opacity(0.1)
//
//            VStack {
//                Chart (sales) { pancake in
//                    BarMark(x: .value("Name", pancake.name),
//                            yStart: .value("Sales", pancake.sold),
//                            yEnd: .value("Sales", pancake.sold * 2),
//                            width: .ratio(0.3)
//                    ).clipShape(RoundedRectangle(cornerRadius: 15))
//                }
//                .chartXAxis(.hidden)
//                .padding([.top, .bottom], 50)
//                .padding([.leading, .trailing], 30)
//            }
//        }
//        .padding(20)
        
        NavigationStack {
            ScrollView {
                ForEach(1..<100) {
                    Text("\($0)")
                }
            }
            .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always))
            .scrollIndicators(.hidden)
            .navigationTitle("Foo")
        }
    }
}

struct ContentView: View {
    @State var query: String = "S"
    var body: some View {
        NavigationStack {
            NavigationLink("Next", destination: PanCakesView(query: $query))
        }
    }
}
