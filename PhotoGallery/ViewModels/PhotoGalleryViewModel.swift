//
//  PhotoGalleryViewModel.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import Foundation
import Combine
import SwiftUI

class PhotoGalleryViewModel: ObservableObject {
    private let apiService: ServiceProtocol
    @Published var albums = [Album]()
    @Published var photos = [Photo]()
    @Published var networkError: APIError?
    
    var cancellables = Set<AnyCancellable>()
    
    init(apiService: ServiceProtocol) {
        self.apiService = apiService
    }
    
    func getAlbumsAndPhotos() {
        let albumURLRequest = PhotoGalleryEndpoint.albums.urlRequest
        let photosURLRequest = PhotoGalleryEndpoint.photos.urlRequest
        let albumsPublisher = apiService.request(with: albumURLRequest)
        let photosPublisher = apiService.request(with: photosURLRequest)
        let cancellable = Publishers.Zip(albumsPublisher, photosPublisher)
            .mapError { _ in APIError.unknown }
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.networkError = error
                case .finished:
                    break
                }
            }, receiveValue: { (albumsResponse, photosResponse) in
                // TODO: Combine way to decode?
                // Publisher.Zip.func decode<Item, Coder>(type: Item.Type, decoder: Coder) -> Publishers.Decode<Publishers.Zip<A, B>, Item, Coder>
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        self.albums = try decoder.decode([Album].self, from: albumsResponse.data)
                        self.photos = try decoder.decode([Photo].self, from: photosResponse.data)
                    } catch {
                        self.networkError = .decodingError
                    }
                }
            })
        cancellables.insert(cancellable)
    }
    
    func getPhotos() {
        let urlRequest = PhotoGalleryEndpoint.photos.urlRequest
        let cancellable = apiService.request(with: urlRequest)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.networkError = error
                case .finished:
                    break
                }
            }, receiveValue: {
                self.photos = $0
            })
        cancellables.insert(cancellable)
    }
}
