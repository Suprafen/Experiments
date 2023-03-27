import SwiftUI

struct ITunesSearchView: View {
    @ObservedObject var vm: ITunesSearchViewModel
    
    @State private var sliderValue: Double = 0.0
    
    init(searchViewModel: ITunesSearchViewModel) {
        self.vm = searchViewModel
    }
    
    var body: some View {
        VStack {
            // just to check whether main thread is blocked.
            Slider(value: $sliderValue)
                .padding(10)
            
            TextField("Search", text: $vm.searchQuery, axis: .horizontal)
                .lineLimit(1)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            if vm.resultsAvailable {
                List {
                    ForEach(vm.searchResults, id: \.self) { result in
                        VStack(alignment: .leading) {
                            Text(result)
                                .font(.title3)
                        }
                    }
                }
            }
        }
        .padding(20)
    }
}

struct ITunesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ITunesSearchView(searchViewModel:
                            ITunesSearchViewModel(networkManager:
                                                    ITunesNetworkManager()))
    }
}
