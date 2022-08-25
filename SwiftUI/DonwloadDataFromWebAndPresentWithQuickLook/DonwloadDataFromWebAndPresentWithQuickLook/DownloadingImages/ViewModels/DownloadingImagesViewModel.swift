//
//  DownloadingImagesViewModel.swift
//  DonwloadDataFromWebAndPresentWithQuickLook
//
//  Created by Ivan Pryhara on 20.07.22.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
                
            }
     }
}
