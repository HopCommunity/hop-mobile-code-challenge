//
//  Album.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/26/20.
//

import Foundation

struct Album: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
}
