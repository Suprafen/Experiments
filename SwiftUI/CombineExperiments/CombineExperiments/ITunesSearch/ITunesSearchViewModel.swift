//
//  ITunesSearchViewModel.swift
//  CombineExperiments
//
//  Created by Ivan Pryhara on 24.03.23.
//

import Foundation
import Combine

class ITunesSearchViewModel: ObservableObject {
    
    enum ITunesSearchViewModelError: Error {
        case unableToUnwrapResults
    }
    
    @MainActor @Published var searchResults = [String]()
    @Published var searchQuery: String = ""
    @Published var resultsAvailable: Bool = false
    
    
    var networkManager: ITunesNetworkManager
    private var cancellables: [AnyCancellable] = []
    
    init(networkManager: ITunesNetworkManager) {
        self.networkManager = networkManager
        addSearchQuerySubscriber()
        addSearchResultsSubscriber()
    }
    
    private func addSearchQuerySubscriber() {
        
        $searchQuery
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self, text.count > 0 else { return }
                Task {
                    await self.getData()
                }
            }
            .store(in: &cancellables)
        
    }
    
    private func addSearchResultsSubscriber() {
        $searchResults
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] receivedValue in
                if receivedValue.count > 0 {
                    self?.resultsAvailable = true
                } else {
                    self?.resultsAvailable = false
                }
            }
            .store(in: &cancellables)
    }
    
    func getData() async {
        let getDataTask = Task{ [weak self] () -> [String] in
            do {
                guard let unwrappedResults = try await self?.networkManager.getData(from: APIEndpoint.search.urlString(searchQuery: searchQuery,                                                                    with: ["limit":"5", "media":"music"])).map({"\($0.artistName) \($0.trackName)"}) else {
                    throw ITunesSearchViewModelError.unableToUnwrapResults
                }
                
                return unwrappedResults
                
            } catch {
                // catch an error
                fatalError(error.localizedDescription)
            }
        }
        
        let taskResult = await getDataTask.result
        
        do {
            try await MainActor.run {
                self.searchResults = try taskResult.get()
            }
            
        } catch {
            // catch error
            fatalError(error.localizedDescription)
        }
    }
}
