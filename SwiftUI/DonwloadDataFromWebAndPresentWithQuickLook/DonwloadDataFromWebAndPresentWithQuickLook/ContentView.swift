//
//  ContentView.swift
//  DonwloadDataFromWebAndPresentWithQuickLook
//
//  Created by Ivan Pryhara on 20.07.22.
//

import SwiftUI
import Combine


class CacheManager {
    static let instance = CacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let imageCache = NSCache<NSString, UIImage>()
        imageCache.countLimit = 50
        imageCache.totalCostLimit = 1024 * 1024 * 100
        return imageCache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to cache")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        imageCache.object(forKey: "" as NSString)?.configuration.
        print("Removed from cache")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    let imageName: String = "gastrofest"
    let manager = CacheManager.instance
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
    
}

struct ContentView: View {
    
    @StateObject var vm = CacheViewModel()
    
    @ObservedObject var fetchSaver = FetcherSaver(linkToImage: URL(string: "https://www.hackingwithswift.com/img/paul.png")!)
    
    
    var body: some View {
        PreviewController(url: URL(string: "/Users/ivanpryhara/Library/Developer/CoreSimulator/Devices/E17DDB03-2E2D-4641-8542-015B44A668AB/data/Containers/Data/Application/97BA1888-1CC6-4CBB-A365-0FEF0038D8BC/tmp/CFNetworkDownload_mHPZWF.tmp")!)
        Text("\(fetchSaver.linkToImage)")
        
        Button {
            fetchSaver.saveData(from: URL(string: "https://www.hackingwithswift.com/img/paul.png")!)
            print("LINK TO IMAGE:", fetchSaver.linkToImage)
        } label: {
            Text("Click")
        }

//        NavigationView {
//            VStack {
//                if let image = vm.startingImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 200, height: 200)
//                        .clipped()
//                        .cornerRadius(10)
//                }
//
//                Spacer()
//
//                HStack {
//                    Button {
//                        vm.saveToCache()
//
//                    } label: {
//                        Text("Load to cache")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
//                    Button {
//                        vm.removeFromCache()
//                    } label: {
//                        Text("Delete")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.red)
//                            .cornerRadius(10)
//                    }
//
//                    Button {
//                        vm.getFromCache()
//                    } label: {
//                        Text("Get")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.green)
//                            .cornerRadius(10)
//                    }
//
//
//
//                }
//                if let image = vm.cachedImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 200, height: 200)
//                        .clipped()
//                        .cornerRadius(10)
//                }
//                Spacer()
//
//            }.navigationTitle("Gastrofest")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class FetcherSaver: ObservableObject {
    
    let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let linkToImage: URL
    @Published var fileDirectory: URL?
    
    init(linkToImage: URL) {
        self.linkToImage = linkToImage
        saveData(from: linkToImage)
    }
    
    func saveData(from url: URL) {
        
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let targetURL = documentURL.appendingPathComponent(linkToImage.lastPathComponent)
        
        URLSession.shared.downloadTask(with: url) { link, response, error in
            print(link)
            DispatchQueue.main.async {
                self.fileDirectory = link
            }
        }.resume()
    }
}
//MARK: - Image Loader
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL
    
    private var cancellable: AnyCancellable?
    
    private var cache: ImageCache?
    
    private(set) var isLoading = false
    
    private static let imageProcessingQueue = DispatchQueue(label: "ImageProcessing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
        func load() {
            
            guard !isLoading else { return }
            
            if let image = cache?[url] {
                self.image = image
                return
            }
           
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .handleEvents(receiveSubscription: {[weak self] _ in self?.onStart() },
                              receiveOutput: {[weak self] in self?.cache($0)},
                              receiveCompletion: {[weak self] _ in self?.onFinish() },
                              receiveCancel: {[weak self] in self?.onFinish()})
                .subscribe(on: Self.imageProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in self?.image = $0 }
        }
       
        private func onStart() {
            isLoading = true
        }
        
        private func onFinish() {
            isLoading = false
        }
    
        private func cache(_ image: UIImage?) {
            image.map { cache?[url] = $0 }
        }
    
       func cancel() {
           cancellable?.cancel()
       }
}

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
//MARK: - ImageCache
protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
