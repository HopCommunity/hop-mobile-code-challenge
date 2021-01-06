//
//  ImageModel.swift
//  ImageGallery
//
//  Created by Slayer on 1/6/21.
//

import Foundation

struct ImageModel: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
