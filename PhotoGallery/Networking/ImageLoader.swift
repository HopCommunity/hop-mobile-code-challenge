//
//  ImageLoader.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/20/20.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        let urlRequest = PhotoGalleryEndpoint.photo(url: url).urlRequest
        
        // TODO: Struct 'APIService' requires that 'UIImage' conform to 'Decodable'
//        cancellable = APIService.instance.request(with: urlRequest)
//            .sink(receiveCompletion: { result in
//                switch result {
//                case .failure( _):
//                    break
//                case .finished:
//                    break
//                }
//            }) {
//                self.image = $0
//            }
        cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
