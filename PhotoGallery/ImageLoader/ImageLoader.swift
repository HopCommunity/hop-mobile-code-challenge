//
//  ImageLoader.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/20/20.
//

import Foundation
import SwiftUI
import Combine

// Based on https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/
class ImageLoader: ObservableObject {
    private let apiService: ServiceProtocol
    
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    private var cache: ImageCache?
    
    init(apiService: ServiceProtocol, url: URL, cache: ImageCache? = nil) {
        self.apiService = apiService
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func getPhoto() {
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        let urlRequest = PhotoGalleryEndpoint.photo(url: url).urlRequest
        
        // TODO: Struct 'APIService' requires that 'UIImage' conform to 'Decodable'
//        cancellable = apiService.request(with: urlRequest)
//            .sink(receiveCompletion: { result in
//                switch result {
//                case .failure(_):
//                    break
//                case .finished:
//                    break
//                }
//            }) {
//                self.image = $0
//            }
        
        cancellable = apiService.request(with: urlRequest)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in self?.cache($0) })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
