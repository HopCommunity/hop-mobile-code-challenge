//
//  PhotoGalleryEndpoint.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import Foundation

enum PhotoGalleryEndpoint {
    case photos
    case photo(url: URL)
}

extension PhotoGalleryEndpoint {
    var urlRequest: URLRequest {
        switch self {
        case .photos:
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
                preconditionFailure("Invalid URL")
            }
            return URLRequest(url: url)
        case .photo(let url):
            return URLRequest(url: url)
        }
    }
}
