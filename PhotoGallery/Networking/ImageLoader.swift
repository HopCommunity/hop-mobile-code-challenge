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
    private let apiService: ServiceProtocol
    
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(apiService: ServiceProtocol, url: URL) {
        self.apiService = apiService
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func getPhoto() {
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
        
        cancellable = apiService.request(with: urlRequest)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
