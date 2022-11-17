//
//  ImagesScroll.swift
//  Everything
//
//  Created by Ivan Pryhara on 17.11.22.
//

import Foundation
import SwiftUI


struct ImageAttachment: Hashable, Identifiable {
    var id = UUID()
    var image: UIImage
}

class ImageHolder: ObservableObject {
    @Published var images: [ImageAttachment] = [
        ImageAttachment(image: UIImage(systemName: "mic")!),
        ImageAttachment(image: UIImage(systemName: "gear")!),
        ImageAttachment(image: UIImage(systemName: "car")!),
        ImageAttachment(image: UIImage(systemName: "bus")!),
        ImageAttachment(image: UIImage(systemName: "drop")!)
    ]
    
    @Published var currentImage: ImageAttachment = ImageAttachment(image: UIImage(systemName: "figure.walk")!)
    
    @Published var selectedImageID: Int = 0
}


struct ImagesScroll: View {
    
    @StateObject var imageHolder = ImageHolder()
    
    var body: some View {
        // Selection through selected image ID
        TabView(selection: $imageHolder.selectedImageID) {
            ForEach(Array(zip(imageHolder.images.indices, imageHolder.images)), id: \.1) { index, image in
                Image(uiImage: image.image)
                    .tag(index) // tag as current index!
                    .onAppear {
                        print("Image #\(index) loaded!")
                    }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .top, content: {
            ZStack{
                HStack {
                    Spacer()
                    Text("\(imageHolder.selectedImageID + 1) of \(imageHolder.images.count)")
                        .bold()
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
            .padding()
            .background(Color.black.opacity(0.55))
        })
    }
}
