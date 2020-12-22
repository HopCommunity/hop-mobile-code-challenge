//
//  MockAPIService.swift
//  PhotoGalleryTests
//
//  Created by Paul Carroll on 12/22/20.
//

import Foundation
import Combine

struct MockAPIService: ServiceProtocol {
    static let instance = MockAPIService()

    func request<T>(with urlRequest: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let photos = [Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL")]
        let photos: [Photo] = []
        guard let data: Data = try? JSONSerialization.data(withJSONObject: photos, options: []) else {
            preconditionFailure("Failed to create data from \(photos)")
        }
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { _ in .decodingError }
            .eraseToAnyPublisher()
    }
}
