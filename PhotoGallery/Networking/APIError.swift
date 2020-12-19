//
//  APIError.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
