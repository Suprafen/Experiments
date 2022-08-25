//
//  DownloadingImages.swift
//  DonwloadDataFromWebAndPresentWithQuickLook
//
//  Created by Ivan Pryhara on 20.07.22.
//

import SwiftUI

struct DownloadingImages: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImages_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImages()
    }
}
