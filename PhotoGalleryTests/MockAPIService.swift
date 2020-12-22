//
//  MockAPIService.swift
//  PhotoGalleryTests
//
//  Created by Paul Carroll on 12/22/20.
//

import Foundation
import Combine

struct MockAPIService: ServiceProtocol {
    var data: Data
    
    init(data: Data) {
        self.data = data
    }

    func request<T>(with urlRequest: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { _ in .decodingError }
            .eraseToAnyPublisher()
    }
}
