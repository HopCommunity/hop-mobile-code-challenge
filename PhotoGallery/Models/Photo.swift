//
//  Photo.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import Foundation

struct Photo: Codable, Identifiable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
