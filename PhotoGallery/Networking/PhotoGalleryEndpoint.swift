//
//  PhotoGalleryEndpoint.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import Foundation

enum PhotoGalleryEndpoint {
    case albums
    case photos
    case photo(url: URL)
}

extension PhotoGalleryEndpoint {
    var urlRequest: URLRequest {
        switch self {
        case .albums:
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {
                preconditionFailure("Invalid URL for albums")
            }
            return URLRequest(url: url)
        case .photos:
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
                preconditionFailure("Invalid URL for photos")
            }
            return URLRequest(url: url)
        case .photo(let url):
            return URLRequest(url: url)
        }
    }
}
