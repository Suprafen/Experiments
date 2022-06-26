//
//  NotationFile.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 23.06.22.
//

import SwiftUI

class FetchingDataViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    @Published var isLoading: Bool = false
    func fetchData(query: String)  {
        DispatchQueue.global(qos: .background).async {
            var data: [String] = []
            DispatchQueue.main.async {
                data = []
            }
        
        
            data = self.downloadData().filter { item in
                item.prefix(query.count).contains(query)
            }
        
            DispatchQueue.main.async {
                self.dataArray = data
                print("Data structured!")
                self.isLoading = false
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0...1_000_000 {
            data.append("\(x)")
        }
        return data
    }
}


//                    viewModel.dataArray.isEmpty ? true : $0.prefix(queryText.count).contains(queryText)
//                    self.items.isEmpty ? true : String($0).prefix(queryText.count).contains(queryText)

struct FetchingDataView: View {
    @State var queryText: String = ""
//    @State var isLoading: Bool = false
    @State var rowChosen: String = ""
    @ObservedObject var viewModel = FetchingDataViewModel()
    
    var body: some View {
        List {
            SearchBarView(queryText: $queryText)
                .environmentObject(viewModel)

                ForEach($viewModel.dataArray, id: \.self) { item in
                    Button {
                        rowChosen = item.wrappedValue
                    } label: {
                        HStack {
                            Text(item.wrappedValue)
                            Spacer()
                            if rowChosen == item.wrappedValue { Circle().scale(0.1).foregroundColor(.blue.opacity(0.1)) }
                        }
                    }
                }
        }.overlay {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .animation(.default, value: viewModel.dataArray)
        .listStyle(.plain)
    }
}

struct SearchBarView: View {
    @Binding var queryText: String
    @EnvironmentObject var viewModel: FetchingDataViewModel
    
    var body: some View {
        HStack {
            TextField("Query", text: $queryText)
                .overlay(
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            viewModel.dataArray = []
                            viewModel.isLoading = true
                            viewModel.fetchData(query: queryText)
                        }, alignment: .trailing
                )
        }
        .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.15))
            )
            .padding(10)
    }
}

struct NotationFile_Previews: PreviewProvider {
    static var previews: some View {
        FetchingDataView()
    }
}
