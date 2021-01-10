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
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    private let apiService: ServiceProtocol
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
        
//        cancellable = apiService.request(with: urlRequest)
//            .mapError { _ in APIError.unknown }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { result in
//                switch result {
//                case .failure(_):
//                    break
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] response in
//                self?.image = UIImage(data: response.data)
//            })
        cancellable = apiService.request(with: urlRequest)
            .subscribe(on: Self.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
