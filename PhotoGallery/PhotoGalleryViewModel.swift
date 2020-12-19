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
    private let apiService = APIService()
    @Published var photos = [Photo]()
    @Published var networkError: APIError?
    
    var cancellables = Set<AnyCancellable>()
    
    func getPhotos() {
        let cancellable = self.getPhotos()
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.networkError = error
                case .finished:
                    break
                }
            }) { photos in
                self.photos = photos
            }
        cancellables.insert(cancellable)
    }
    
    private func getPhotos() -> AnyPublisher<[Photo], APIError> {
        return apiService.request(with: PhotoGalleryEndpoint.photos.urlRequest)
            .eraseToAnyPublisher()
    }
}
